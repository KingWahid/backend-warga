package usecase

import (
	"context"
	"backend-warga/internal/model"
	"backend-warga/internal/repository"
)

type RTUsecase interface {
	CreateRT(ctx context.Context, rt *model.RT) error
	GetRTByKelurahanID(ctx context.Context, kelurahanID uint) ([]model.RT, error)
}

type rtUsecase struct {
	repo repository.RTRepository
}

func NewRTUsecase(repo repository.RTRepository) RTUsecase {
	return &rtUsecase{repo}
}

func (u *rtUsecase) CreateRT(ctx context.Context, rt *model.RT) error {
	return u.repo.CreateRT(ctx, rt)
}

func (u *rtUsecase) GetRTByKelurahanID(ctx context.Context, kelurahanID uint) ([]model.RT, error) {
	return u.repo.GetRTByKelurahanID(ctx, kelurahanID)
}
