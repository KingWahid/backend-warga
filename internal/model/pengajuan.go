package model

import (
	"time"

	"gorm.io/gorm"
)

type Pengajuan struct {
	ID         string         `json:"id" gorm:"primaryKey;type:uuid;default:gen_random_uuid()"`
	SuratID    string         `json:"surat_id" gorm:"not null"`
	Surat      Surat          `json:"surat" gorm:"foreignKey:SuratID"`
	WargaID    string         `json:"warga_id" gorm:"not null"`
	Warga      Warga          `json:"warga" gorm:"foreignKey:WargaID"`
	Status     string         `json:"status" gorm:"not null;default:'pending'"`
	Alasan     *string        `json:"alasan"`
	CreatedAt  time.Time      `json:"created_at"`
	UpdatedAt  time.Time      `json:"updated_at"`
	DeletedAt  gorm.DeletedAt `json:"deleted_at" gorm:"index"`
	ApprovedBy *string        `json:"approved_by"`
	ApprovedAt *time.Time     `json:"approved_at"`
	RejectedBy *string        `json:"rejected_by"`
	RejectedAt *time.Time     `json:"rejected_at"`
	Notes      *string        `json:"notes"`
}

func (Pengajuan) TableName() string {
    return "pengajuan"
}