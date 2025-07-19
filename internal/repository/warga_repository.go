package repository

import (
	"context"
	"fmt"

	"backend-warga/internal/model"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type WargaRepository interface {
	Create(ctx context.Context, warga *model.Warga) error
	GetByID(ctx context.Context, id uuid.UUID) (*model.Warga, error)
	GetByNIK(ctx context.Context, nik string) (*model.Warga, error)
	GetByNoKK(ctx context.Context, noKK string) ([]*model.Warga, error)
	GetAll(ctx context.Context) ([]*model.Warga, error)
	Update(ctx context.Context, warga *model.Warga) error
	Delete(ctx context.Context, id uuid.UUID) error
	GetKepalaKeluargaByNoKK(ctx context.Context, noKK string) (*model.Warga, error)
	GetAnggotaKeluargaByNoKK(ctx context.Context, noKK string) ([]*model.Warga, error)
}

type wargaRepository struct {
	db *gorm.DB
}

func NewWargaRepository(db *gorm.DB) WargaRepository {
	return &wargaRepository{db: db}
}

func (r *wargaRepository) Create(ctx context.Context, warga *model.Warga) error {
	if err := r.db.WithContext(ctx).Create(warga).Error; err != nil {
		fmt.Printf("failed to create warga: %v\n", err)
		return err
	}
	return nil
}

func (r *wargaRepository) GetByID(ctx context.Context, id uuid.UUID) (*model.Warga, error) {
	var warga model.Warga
	err := r.db.WithContext(ctx).Preload("KartuKeluarga").Where("id = ?", id).First(&warga).Error
	if err != nil {
		if err == gorm.ErrRecordNotFound {
			return nil, fmt.Errorf("warga with id %s not found", id)
		}
		return nil, fmt.Errorf("error getting warga by id: %w", err)
	}
	return &warga, nil
}

func (r *wargaRepository) GetByNIK(ctx context.Context, nik string) (*model.Warga, error) {
	var warga model.Warga
	err := r.db.WithContext(ctx).Preload("KartuKeluarga").Where("nik = ?", nik).First(&warga).Error
	if err != nil {
		if err == gorm.ErrRecordNotFound {
			return nil, nil
		}
		return nil, fmt.Errorf("error getting warga by nik: %w", err)
	}
	return &warga, nil
}

func (r *wargaRepository) GetByNoKK(ctx context.Context, noKK string) ([]*model.Warga, error) {
	var wargas []*model.Warga
	err := r.db.WithContext(ctx).Preload("KartuKeluarga").Where("no_kk = ?", noKK).Order("created_at ASC").Find(&wargas).Error
	if err != nil {
		return nil, fmt.Errorf("error getting warga by no_kk: %w", err)
	}
	return wargas, nil
}

func (r *wargaRepository) GetAll(ctx context.Context) ([]*model.Warga, error) {
	var wargas []*model.Warga
	err := r.db.WithContext(ctx).Preload("KartuKeluarga").Order("created_at DESC").Find(&wargas).Error
	if err != nil {
		return nil, fmt.Errorf("error getting all warga: %w", err)
	}
	return wargas, nil
}

func (r *wargaRepository) Update(ctx context.Context, warga *model.Warga) error {
	result := r.db.WithContext(ctx).Save(warga)
	if result.Error != nil {
		return fmt.Errorf("error updating warga: %w", result.Error)
	}
	if result.RowsAffected == 0 {
		return fmt.Errorf("warga not found")
	}
	return nil
}

func (r *wargaRepository) Delete(ctx context.Context, id uuid.UUID) error {
	result := r.db.WithContext(ctx).Where("id = ?", id).Delete(&model.Warga{})
	if result.Error != nil {
		return fmt.Errorf("error deleting warga: %w", result.Error)
	}
	if result.RowsAffected == 0 {
		return fmt.Errorf("warga not found")
	}
	return nil
}

func (r *wargaRepository) GetKepalaKeluargaByNoKK(ctx context.Context, noKK string) (*model.Warga, error) {
	var warga model.Warga
	err := r.db.WithContext(ctx).Preload("KartuKeluarga").Where("no_kk = ? AND status_keluarga = ?", noKK, model.StatusKeluargaKepalaKeluarga).First(&warga).Error
	if err != nil {
		if err == gorm.ErrRecordNotFound {
			return nil, nil
		}
		return nil, fmt.Errorf("error getting kepala keluarga: %w", err)
	}
	return &warga, nil
}

func (r *wargaRepository) GetAnggotaKeluargaByNoKK(ctx context.Context, noKK string) ([]*model.Warga, error) {
	var wargas []*model.Warga
	err := r.db.WithContext(ctx).Preload("KartuKeluarga").Where("no_kk = ?", noKK).Order("created_at ASC").Find(&wargas).Error
	if err != nil {
		return nil, fmt.Errorf("error getting anggota keluarga: %w", err)
	}
	return wargas, nil
}
