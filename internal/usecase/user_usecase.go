package usecase

import (
	"context"
	"backend-warga/internal/model"
	"backend-warga/internal/repository"
	"backend-warga/pkg/utils"
	"fmt"
)

type UserUseCase interface {
	FindUserByEmailPassword(email, password string) (*model.User, error)
	Create(ctx context.Context, user *model.User) error
}

type userUseCase struct {
	repo repository.UserRepository
}

func NewUserUseCase(repo repository.UserRepository) UserUseCase {
	return &userUseCase{repo: repo}
}

func (u *userUseCase) FindUserByEmailPassword(email, password string) (*model.User, error) {
	ctx := context.Background()
	user, err := u.repo.FindByEmail(ctx, email)
	if err != nil {
		return nil, fmt.Errorf("user not found: %w", err)
	}
	if user == nil {
		return nil, fmt.Errorf("user not found")
	}
	if !utils.CheckPassword(user.Password, password) {
		return nil, fmt.Errorf("invalid password")
	}
	return user, nil
}

func (u *userUseCase) Create(ctx context.Context, user *model.User) error {
	return u.repo.Create(ctx, user)
} 