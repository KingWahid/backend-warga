package model

import (
	"time"
	"gorm.io/gorm"
)

type Surat struct {
	ID            string         `json:"id" gorm:"primaryKey;type:uuid;default:gen_random_uuid()"`
	Nama          string         `json:"nama" gorm:"not null"`
	Deskripsi     string         `json:"deskripsi" gorm:"not null"`
	Template      string         `json:"template" gorm:"not null;type:text"`
	RequiredFields string        `json:"required_fields" gorm:"not null;type:json"`
	Kategori      string         `json:"kategori" gorm:"not null"`
	CreatedAt     time.Time      `json:"created_at"`
	UpdatedAt     time.Time      `json:"updated_at"`
	DeletedAt     gorm.DeletedAt `json:"deleted_at" gorm:"index"`
} 

func (Surat) TableName() string {
    return "surat"
}