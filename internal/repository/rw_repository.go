package repository

import (
	"context"
	"backend-warga/internal/model"
	"gorm.io/gorm"
)

type RWRepository interface {
	CreateRW(ctx context.Context, rw *model.RW) error
	GetRWByKelurahanID(ctx context.Context, kelurahanID uint) ([]model.RW, error)
}

type rwRepository struct {
	db *gorm.DB
}

func NewRWRepository(db *gorm.DB) RWRepository {
	return &rwRepository{db}
}

func (r *rwRepository) CreateRW(ctx context.Context, rw *model.RW) error {
	return r.db.WithContext(ctx).Create(rw).Error
}

func (r *rwRepository) GetRWByKelurahanID(ctx context.Context, kelurahanID uint) ([]model.RW, error) {
	var rw []model.RW
	err := r.db.WithContext(ctx).Where("kelurahan_id = ?", kelurahanID).Find(&rw).Error
	return rw, err
}
