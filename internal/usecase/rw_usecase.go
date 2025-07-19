package usecase

import (
	"context"
	"backend-warga/internal/model"
	"backend-warga/internal/repository"
)

type RWUsecase interface {
	CreateRW(ctx context.Context, rw *model.RW) error
	GetRWByKelurahanID(ctx context.Context, kelurahanID uint) ([]model.RW, error)
}

type rwUsecase struct {
	repo repository.RWRepository
}

func NewRWUsecase(repo repository.RWRepository) RWUsecase {
	return &rwUsecase{repo}
}

func (u *rwUsecase) CreateRW(ctx context.Context, rw *model.RW) error {
	return u.repo.CreateRW(ctx, rw)
}

func (u *rwUsecase) GetRWByKelurahanID(ctx context.Context, kelurahanID uint) ([]model.RW, error) {
	return u.repo.GetRWByKelurahanID(ctx, kelurahanID)
}
