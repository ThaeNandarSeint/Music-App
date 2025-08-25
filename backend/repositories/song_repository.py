from database import SessionLocal
from models.song_model import Song
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

    def get_by_id(self, id: int):
        return self.db.query(Song).filter(Song.id == id).first()
    
    def find_one(self, field: str, value):
        model_field = getattr(Song, field, None)
        if model_field is None:
            raise ValueError(f"Invalid field: {field}")
        
        return self.db.query(Song).filter(model_field == value).first()

    def create(self, data: CreateSong):
        db_data = Song(**data)
        self.db.add(db_data)
        self.db.commit()
        self.db.refresh(db_data)
        return db_data

    def update(self, id: int, data: UpdateSong):
        db_data = self.get_by_id(id)
        if db_data:
            db_data.name = data.name
            db_data.email = data.email
            self.db.commit()
            self.db.refresh(db_data)
        return db_data

    def delete(self, song_id: int):
        db_song = self.get_by_id(song_id)
        if db_song:
            self.db.delete(db_song)
            self.db.commit()
        return db_song