from fastapi import HTTPException, UploadFile
from services.song_service import SongService
from schemas.song_schema import CreateSong, GetSongsDto, UpdateSong

class SongUseCase:
    def __init__(self):
        self.service = SongService()

    def get_songs(self, queries: GetSongsDto):
        return self.service.get_songs(queries)

    def get_song_by_id(self, id: int):
        data = self.service.get_song(id)
        if not data:
            raise HTTPException(status_code=400, detail="Song not found")
        return data

    def create_song(self, data: CreateSong, thumbnail: UploadFile, audio: UploadFile):
        return self.service.create_song(data, thumbnail, audio)

    def update_song(self, id: int, data: UpdateSong):
        return self.service.update_song(id, data)

    def delete_song(self, id: int):
        return self.service.delete_song(id)