package usecase

import (
	"context"
	"backend-warga/internal/model"
	"backend-warga/internal/repository"
)

type WilayahUsecase interface {
	GetAllProvinsi(ctx context.Context) ([]model.Provinsi, error)
	GetKotaByProvinsi(ctx context.Context, provinsiID uint) ([]model.Kota, error)
	GetKecamatanByKota(ctx context.Context, kotaID uint) ([]model.Kecamatan, error)
	GetKelurahanByKecamatan(ctx context.Context, kecamatanID uint) ([]model.Kelurahan, error)
}

type wilayahUsecase struct {
	repo repository.WilayahRepository
}

func NewWilayahUsecase(repo repository.WilayahRepository) WilayahUsecase {
	return &wilayahUsecase{repo}
}

func (u *wilayahUsecase) GetAllProvinsi(ctx context.Context) ([]model.Provinsi, error) {
	return u.repo.GetAllProvinsi(ctx)
}

func (u *wilayahUsecase) GetKotaByProvinsi(ctx context.Context, provinsiID uint) ([]model.Kota, error) {
	return u.repo.GetKotaByProvinsi(ctx, provinsiID)
}

func (u *wilayahUsecase) GetKecamatanByKota(ctx context.Context, kotaID uint) ([]model.Kecamatan, error) {
	return u.repo.GetKecamatanByKota(ctx, kotaID)
}

func (u *wilayahUsecase) GetKelurahanByKecamatan(ctx context.Context, kecamatanID uint) ([]model.Kelurahan, error) {
	return u.repo.GetKelurahanByKecamatan(ctx, kecamatanID)
}