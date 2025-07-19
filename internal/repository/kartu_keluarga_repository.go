package repository

import (
	"context"
	"fmt"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"backend-warga/internal/model"
)

type KartuKeluargaRepository interface {
	Create(ctx context.Context, kk *model.KartuKeluarga) error
	GetByID(ctx context.Context, id uuid.UUID) (*model.KartuKeluarga, error)
	GetByNoKK(ctx context.Context, noKK string) (*model.KartuKeluarga, error)
	GetAll(ctx context.Context) ([]*model.KartuKeluarga, error)
	Update(ctx context.Context, kk *model.KartuKeluarga) error
	Delete(ctx context.Context, id uuid.UUID) error
}

type kartuKeluargaRepository struct {
	db *gorm.DB
}

func NewKartuKeluargaRepository(db *gorm.DB) KartuKeluargaRepository {
	return &kartuKeluargaRepository{db: db}
}

func (r *kartuKeluargaRepository) Create(ctx context.Context, kk *model.KartuKeluarga) error {
	return r.db.WithContext(ctx).Create(kk).Error
}

func (r *kartuKeluargaRepository) GetByID(ctx context.Context, id uuid.UUID) (*model.KartuKeluarga, error) {
	var kk model.KartuKeluarga
	err := r.db.WithContext(ctx).Where("id = ?", id).First(&kk).Error
	if err != nil {
		if err == gorm.ErrRecordNotFound {
			return nil, nil
		}
		return nil, fmt.Errorf("error getting kartu keluarga by id: %w", err)
	}
	return &kk, nil
}

func (r *kartuKeluargaRepository) GetByNoKK(ctx context.Context, noKK string) (*model.KartuKeluarga, error) {
	var kk model.KartuKeluarga
	err := r.db.WithContext(ctx).Where("no_kk = ?", noKK).First(&kk).Error
	if err != nil {
		if err == gorm.ErrRecordNotFound {
			return nil, nil
		}
		return nil, fmt.Errorf("error getting kartu keluarga by no_kk: %w", err)
	}
	return &kk, nil
}

func (r *kartuKeluargaRepository) GetAll(ctx context.Context) ([]*model.KartuKeluarga, error) {
	var kartuKeluargas []*model.KartuKeluarga
	err := r.db.WithContext(ctx).Order("created_at DESC").Find(&kartuKeluargas).Error
	if err != nil {
		return nil, fmt.Errorf("error getting all kartu keluarga: %w", err)
	}
	return kartuKeluargas, nil
}

func (r *kartuKeluargaRepository) Update(ctx context.Context, kk *model.KartuKeluarga) error {
	result := r.db.WithContext(ctx).Save(kk)
	if result.Error != nil {
		return fmt.Errorf("error updating kartu keluarga: %w", result.Error)
	}
	if result.RowsAffected == 0 {
		return fmt.Errorf("kartu keluarga not found")
	}
	return nil
}

func (r *kartuKeluargaRepository) Delete(ctx context.Context, id uuid.UUID) error {
	result := r.db.WithContext(ctx).Where("id = ?", id).Delete(&model.KartuKeluarga{})
	if result.Error != nil {
		return fmt.Errorf("error deleting kartu keluarga: %w", result.Error)
	}
	if result.RowsAffected == 0 {
		return fmt.Errorf("kartu keluarga not found")
	}
	return nil
} 