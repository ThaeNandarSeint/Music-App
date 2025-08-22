from sqlalchemy import Column, Integer, String
from database import Base

class Song(Base):
    __tablename__ = "songs"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    name = Column(String, index=True)
    artist = Column(String, index=True)
    song_url = Column(String)
    thumbnail_url = Column(String)
    color = Column(String)
    