from sqlalchemy import Column, Integer, String
from database import Base
from sqlalchemy.orm import relationship

class Song(Base):
    __tablename__ = "songs"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    name = Column(String, index=True)
    artist = Column(String, index=True)
    color = Column(String)
    audio_url = Column(String)
    audio_public_id = Column(String)
    thumbnail_url = Column(String)
    thumbnail_public_id = Column(String)
    