from fastapi import HTTPException, UploadFile
from schemas.song_schema import CreateSong, GetSongsDto, UpdateSong
from repositories.song_repository import SongRepository
from services.password_service import PasswordService
from services.file_service import FileService

class SongService:
    def __init__(self):
        self.repository = SongRepository()
        self.password_service = PasswordService()
        self.file_service = FileService()

    def get_songs(self, queries: GetSongsDto):
        return self.repository.get_all(queries)

    def get_song(self, id: int):
        return self.repository.get_by_id(id)
    
    def get_song_by_name(self, name: str):
        return self.repository.find_one('name', name)
    
    async def create_song(self, payload: CreateSong, thumbnail: UploadFile,audio: UploadFile):
        old_song = self.get_song_by_name(payload.name)
        if old_song:
            raise HTTPException(status_code=400, detail="This name already registered.")
        
        thumbnail_file = await self.file_service.upload_file(thumbnail, '/thumbnails')
        audio_file = await self.file_service.upload_file(audio, '/songs')

        data = CreateSong(**{
            "thumbnail_public_id": thumbnail_file['public_id'],
            "thumbnail_url": thumbnail_file['secure_url'],
            "audio_public_id": audio_file['public_id'],
            "audio_url": audio_file['secure_url'],
            "name": payload.name,
            "artist": payload.artist,
            "color": payload.color,
        })

        song = self.repository.create(data)
        return song

    def update_song(self, id: int, data: UpdateSong):
        return self.repository.update(id, data)

    def delete_song(self, id: int):
        return self.repository.delete(id)