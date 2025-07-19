package repository

import (
	"context"
	"backend-warga/internal/model"
	"gorm.io/gorm"
)

type RTRepository interface {
	CreateRT(ctx context.Context, rt *model.RT) error
	GetRTByKelurahanID(ctx context.Context, kelurahanID uint) ([]model.RT, error)
}

type rtRepository struct {
	db *gorm.DB
}

func NewRTRepository(db *gorm.DB) RTRepository {
	return &rtRepository{db}
}

func (r *rtRepository) CreateRT(ctx context.Context, rt *model.RT) error {
	return r.db.WithContext(ctx).Create(rt).Error
}

func (r *rtRepository) GetRTByKelurahanID(ctx context.Context, kelurahanID uint) ([]model.RT, error) {
	var rt []model.RT
	err := r.db.WithContext(ctx).Where("kelurahan_id = ?", kelurahanID).Find(&rt).Error
	return rt, err
}
