from database import SessionLocal
from models.song_model import Song
from sqlalchemy.orm import joinedload
from schemas.song_schema import CreateSong, GetSongsDto, UpdateSong

class SongRepository:
    def __init__(self):
        self.db = SessionLocal()

    def get_all(self, queries: GetSongsDto):
        dbQuery = self.db.query(Song)

        if queries.search:
            search = f"%{queries.search}%"
            dbQuery = dbQuery.filter(
                (Song.name.ilike(search)) | (Song.email.ilike(search))
            )

        data = dbQuery.offset(queries.skip).limit(queries.limit).all()
        count = dbQuery.count()
        return {
            "data": data,
            "count": count
        }

    def get_by_id(self, song_id: int):
        return self.db.query(Song).filter(Song.id == song_id).first()
    
    def find_one(self, field: str, value):
        model_field = getattr(Song, field, None)
        if model_field is None:
            raise ValueError(f"Invalid field: {field}")
        
        return self.db.query(Song).filter(model_field == value).first()

    def create(self, Song: CreateSong):
        db_Song = Song(**Song)
        self.db.add(db_Song)
        self.db.commit()
        self.db.refresh(db_Song)
        return db_Song

    def update(self, song_id: int, Song: UpdateSong):
        db_Song = self.get_by_id(song_id)
        if db_Song:
            db_Song.name = Song.name
            db_Song.email = Song.email
            self.db.commit()
            self.db.refresh(db_Song)
        return db_Song

    def delete(self, song_id: int):
        db_Song = self.get_by_id(song_id)
        if db_Song:
            self.db.delete(db_Song)
            self.db.commit()
        return db_Song