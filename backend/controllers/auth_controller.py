from fastapi import APIRouter, Depends, Request
from schemas.auth_schema import Login, LoginResponse, Register, RegisterResponse, GetCurrentUserResponse
from usecases.auth_usecase import AuthUseCase

router = APIRouter(prefix="/auth", tags=["Auth"])

def get_usecase():
    return AuthUseCase()

@router.post("/register", response_model=RegisterResponse)
def register_user(data: Register, auth_usecase: AuthUseCase = Depends(get_usecase)):
    return auth_usecase.register(data)

@router.post("/login", response_model=LoginResponse)
def register_user(data: Login, auth_usecase: AuthUseCase = Depends(get_usecase)):
    return auth_usecase.login(data)

@router.get("/me")
def get_current_user(request: Request):
    return {"user": request.state.user}