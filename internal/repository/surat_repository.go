package repository

import (
	"backend-warga/internal/model"

	"gorm.io/gorm"
)

type SuratRepository interface {
	Create(surat *model.Surat) error
	FindByID(id string) (*model.Surat, error)
	FindAll() ([]model.Surat, error)
	Update(surat *model.Surat) error
	Delete(id string) error
}

type suratRepository struct {
	db *gorm.DB
}

func NewSuratRepository(db *gorm.DB) SuratRepository {
	return &suratRepository{db: db}
}

func (r *suratRepository) Create(surat *model.Surat) error {
	return r.db.Create(surat).Error
}

func (r *suratRepository) FindByID(id string) (*model.Surat, error) {
	var surat model.Surat
	err := r.db.Where("id = ?", id).First(&surat).Error
	if err != nil {
		return nil, err
	}
	return &surat, nil
}

func (r *suratRepository) FindAll() ([]model.Surat, error) {
	var suratList []model.Surat
	err := r.db.Find(&suratList).Error
	return suratList, err
}

func (r *suratRepository) Update(surat *model.Surat) error {
	return r.db.Save(surat).Error
}

func (r *suratRepository) Delete(id string) error {
	return r.db.Where("id = ?", id).Delete(&model.Surat{}).Error
}
