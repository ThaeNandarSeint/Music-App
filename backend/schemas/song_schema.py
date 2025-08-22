from pydantic import BaseModel, Field
from typing import Optional

class BaseSong(BaseModel):
    name: str
    artist: str
    color: str

class CreateSong(BaseSong):
    pass

class UpdateSong(BaseSong):
    pass

class Song(BaseSong):
    id: int

class GetSongsResponse(BaseModel):
    data: list[Song]
    count: int

class GetSongsDto(BaseModel):
    skip: int = Field(0, ge=0, description="Number of records to skip")
    limit: int = Field(10, ge=1, le=100, description="Number of records to return")
    search: Optional[str] = Field(None, description="Search keyword")