package model

import "time"

type RT struct {
	ID           uint      `gorm:"primaryKey" json:"id"`
	KelurahanID  uint      `json:"kelurahan_id"`
	RWID         uint      `json:"rw_id"`
	KodeRT       string    `gorm:"size:3" json:"kode_rt"`
	CapImageURL  string    `json:"cap_image_url"`
	TTDImageURL  string    `json:"ttd_image_url"`
	CreatedAt    time.Time `json:"created_at"`
	UpdatedAt    time.Time `json:"updated_at"`
}

func (RT) TableName() string {
    return "rt"
}
