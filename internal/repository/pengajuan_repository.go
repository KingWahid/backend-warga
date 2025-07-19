package repository

import (
	"backend-warga/internal/model"

	"gorm.io/gorm"
)

type PengajuanRepository interface {
	Create(pengajuan *model.Pengajuan) error
	FindByID(id string) (*model.Pengajuan, error)
	FindAll() ([]model.Pengajuan, error)
	FindByWargaID(wargaID string) ([]model.Pengajuan, error)
	FindByStatus(status string) ([]model.Pengajuan, error)
	Update(pengajuan *model.Pengajuan) error
	Delete(id string) error
	Approve(id string, approvedBy string) error
	Reject(id string, rejectedBy string, reason string) error
}

type pengajuanRepository struct {
	db *gorm.DB
}

func NewPengajuanRepository(db *gorm.DB) PengajuanRepository {
	return &pengajuanRepository{db: db}
}

func (r *pengajuanRepository) Create(pengajuan *model.Pengajuan) error {
	return r.db.Create(pengajuan).Error
}

func (r *pengajuanRepository) FindByID(id string) (*model.Pengajuan, error) {
	var pengajuan model.Pengajuan
	err := r.db.Preload("Surat").Preload("Warga").Where("id = ?", id).First(&pengajuan).Error
	if err != nil {
		return nil, err
	}
	return &pengajuan, nil
}

func (r *pengajuanRepository) FindAll() ([]model.Pengajuan, error) {
	var pengajuanList []model.Pengajuan
	err := r.db.Preload("Surat").Preload("Warga").Find(&pengajuanList).Error
	return pengajuanList, err
}

func (r *pengajuanRepository) FindByWargaID(wargaID string) ([]model.Pengajuan, error) {
	var pengajuanList []model.Pengajuan
	err := r.db.Preload("Surat").Preload("Warga").Where("warga_id = ?", wargaID).Find(&pengajuanList).Error
	return pengajuanList, err
}

func (r *pengajuanRepository) FindByStatus(status string) ([]model.Pengajuan, error) {
	var pengajuanList []model.Pengajuan
	err := r.db.Preload("Surat").Preload("Warga").Where("status = ?", status).Find(&pengajuanList).Error
	return pengajuanList, err
}

func (r *pengajuanRepository) Update(pengajuan *model.Pengajuan) error {
	return r.db.Save(pengajuan).Error
}

func (r *pengajuanRepository) Delete(id string) error {
	return r.db.Where("id = ?", id).Delete(&model.Pengajuan{}).Error
}

func (r *pengajuanRepository) Approve(id string, approvedBy string) error {
	return r.db.Model(&model.Pengajuan{}).Where("id = ?", id).Updates(map[string]interface{}{
		"status":      "approved",
		"approved_by": approvedBy,
		"approved_at": gorm.Expr("NOW()"),
	}).Error
}

func (r *pengajuanRepository) Reject(id string, rejectedBy string, reason string) error {
	return r.db.Model(&model.Pengajuan{}).Where("id = ?", id).Updates(map[string]interface{}{
		"status":      "rejected",
		"rejected_by": rejectedBy,
		"rejected_at": gorm.Expr("NOW()"),
		"notes":       reason,
	}).Error
}
