from fastapi import HTTPException
from schemas.song_schema import CreateSong, GetSongsDto, UpdateSong
from repositories.song_repository import SongRepository
from services.password_service import PasswordService

class SongService:
    def __init__(self):
        self.repository = SongRepository()
        self.password_service = PasswordService()

    def get_songs(self, queries: GetSongsDto):
        return self.repository.get_all(queries)

    def get_song(self, id: int):
        return self.repository.get_by_id(id)
    
    def get_song_by_name(self, name: str):
        return self.repository.find_one('name', name)

    def create_song(self, data: CreateSong):
        old_song = self.get_song_by_name(data.name)
        if old_song:
            raise HTTPException(status_code=400, detail="This name already registered.")

        return self.repository.create(data)

    def update_song(self, id: int, data: UpdateSong):
        return self.repository.update(id, data)

    def delete_song(self, id: int):
        return self.repository.delete(id)