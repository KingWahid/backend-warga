package repository

import (
	"context"
	"backend-warga/internal/model"

	"gorm.io/gorm"
)

type WilayahRepository interface {
	GetAllProvinsi(ctx context.Context) ([]model.Provinsi, error)
	GetKotaByProvinsi(ctx context.Context, provinsiID uint) ([]model.Kota, error)
	GetKecamatanByKota(ctx context.Context, kotaID uint) ([]model.Kecamatan, error)
	GetKelurahanByKecamatan(ctx context.Context, kecamatanID uint) ([]model.Kelurahan, error)
}

type wilayahRepository struct {
	db *gorm.DB
}

func NewWilayahRepository(db *gorm.DB) WilayahRepository {
	return &wilayahRepository{db}
}

func (r *wilayahRepository) GetAllProvinsi(ctx context.Context) ([]model.Provinsi, error) {
	var provinsi []model.Provinsi
	err := r.db.WithContext(ctx).Order("nama").Find(&provinsi).Error
	return provinsi, err
}

func (r *wilayahRepository) GetKotaByProvinsi(ctx context.Context, provinsiID uint) ([]model.Kota, error) {
	var kota []model.Kota
	err := r.db.WithContext(ctx).Where("provinsi_id = ?", provinsiID).Order("nama").Find(&kota).Error
	return kota, err
}

func (r *wilayahRepository) GetKecamatanByKota(ctx context.Context, kotaID uint) ([]model.Kecamatan, error) {
	var kecamatan []model.Kecamatan
	err := r.db.WithContext(ctx).Where("kota_id = ?", kotaID).Order("nama").Find(&kecamatan).Error
	return kecamatan, err
}

func (r *wilayahRepository) GetKelurahanByKecamatan(ctx context.Context, kecamatanID uint) ([]model.Kelurahan, error) {
	var kelurahan []model.Kelurahan
	err := r.db.WithContext(ctx).Where("kecamatan_id = ?", kecamatanID).Order("nama").Find(&kelurahan).Error
	return kelurahan, err
}