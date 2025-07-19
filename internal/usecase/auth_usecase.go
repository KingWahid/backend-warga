package usecase

import (
	"backend-warga/pkg/service"
	"fmt"
)

type AuthenticationUseCase interface {
	Login(email string, password string) (string, error)
}

type authenticationUseCase struct {
	userUseCase UserUseCase
	jwtService  service.JwtService
}

func (a *authenticationUseCase) Login(email, password string) (string, error) {
	user, err := a.userUseCase.FindUserByEmailPassword(email, password)
	if err != nil {
		return "", err
	}

	accessToken, err := a.jwtService.CreateToken(*user)
	if err != nil {
		return "", fmt.Errorf("failed to create access token: %w", err)
	}

	return accessToken, nil
}

func NewAuthenticationUseCase(uc UserUseCase, jwtService service.JwtService) AuthenticationUseCase {
	return &authenticationUseCase{userUseCase: uc, jwtService: jwtService}
}
