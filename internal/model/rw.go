package model

import "time"

type RW struct {
	ID           uint      `gorm:"primaryKey" json:"id"`
	KelurahanID  uint      `json:"kelurahan_id"`
	KodeRW       string    `gorm:"size:3" json:"kode_rw"`
	CapImageURL  string    `json:"cap_image_url"`
	TTDImageURL  string    `json:"ttd_image_url"`
	CreatedAt    time.Time `json:"created_at"`
	UpdatedAt    time.Time `json:"updated_at"`
}

func (RW) TableName() string {
    return "rw"
}