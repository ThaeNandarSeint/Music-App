from fastapi import APIRouter, Depends, Query, UploadFile, File
from typing import Optional
from schemas.song_schema import CreateSong, GetSongsDto, GetSongsResponse, UpdateSong, Song
from usecases.song_usecase import SongUseCase

router = APIRouter(prefix="/songs", tags=["songs"])

def get_usecase():
    return SongUseCase()

def get_queries(
    skip: int = Query(0, ge=0),
    limit: int = Query(10, ge=1, le=100),
    search: Optional[str] = Query(None)
) -> GetSongsDto:
    return GetSongsDto(skip=skip, limit=limit, search=search)

@router.get("/", response_model=GetSongsResponse)
def get_songs(queries: GetSongsDto = Depends(get_queries),usecase: SongUseCase = Depends(get_usecase)):
    return usecase.get_songs(queries)

@router.get("/{id}", response_model=Song)
def get_song(id: int, usecase: SongUseCase = Depends(get_usecase)):
    return usecase.get_song_by_id(id)

@router.post("/")
async def create_song(
    data: CreateSong = Depends(CreateSong.as_form),
    thumbnail: UploadFile = File(...),
    audio: UploadFile = File(...),
    usecase: SongUseCase = Depends(get_usecase)
):
    return await usecase.create_song(data, thumbnail, audio)

@router.patch("/{id}", response_model=Song)
def update_song(id: int, data: UpdateSong, usecase: SongUseCase = Depends(get_usecase)):
    return usecase.update_song(id, data)

@router.delete("/{id}", response_model=Song)
def delete_song(id: int, usecase: SongUseCase = Depends(get_usecase)):
    return usecase.delete_song(id)