package model

import (
	"time"

	"github.com/google/uuid"
)

type KartuKeluarga struct {
	ID              uuid.UUID  `json:"id" gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	NoKK            string     `json:"no_kk" gorm:"uniqueIndex;not null"`
	KepalaKeluargaID *uuid.UUID `json:"kepala_keluarga_id,omitempty" gorm:"type:uuid"`
	ProvinsiID      int        `json:"provinsi_id" gorm:"not null"`
	KotaID          int        `json:"kota_id" gorm:"not null"`
	KecamatanID     int        `json:"kecamatan_id" gorm:"not null"`
	KelurahanID     int        `json:"kelurahan_id" gorm:"not null"`
	RTID            int        `json:"rt_id" gorm:"not null"`
	RWID            int        `json:"rw_id" gorm:"not null"`
	Alamat          string     `json:"alamat" gorm:"type:text;not null"`
	KodePos         string     `json:"kode_pos" gorm:"size:5;not null"`
	CreatedAt       time.Time  `json:"created_at" gorm:"autoCreateTime"`
	UpdatedAt       time.Time  `json:"updated_at" gorm:"autoUpdateTime"`
}

type CreateKartuKeluargaRequest struct {
	NoKK            string     `json:"no_kk" validate:"required,min=16,max=16"`
	KepalaKeluargaID *uuid.UUID `json:"kepala_keluarga_id,omitempty"`
	ProvinsiID      int        `json:"provinsi_id" validate:"required"`
	KotaID          int        `json:"kota_id" validate:"required"`
	KecamatanID     int        `json:"kecamatan_id" validate:"required"`
	KelurahanID     int        `json:"kelurahan_id" validate:"required"`
	RTID            int        `json:"rt_id" validate:"required"`
	RWID            int        `json:"rw_id" validate:"required"`
	Alamat          string     `json:"alamat" validate:"required"`
	KodePos         string     `json:"kode_pos" validate:"required,min=5,max=5"`
}

type UpdateKartuKeluargaRequest struct {
	NoKK            string     `json:"no_kk,omitempty" validate:"omitempty,min=16,max=16"`
	KepalaKeluargaID *uuid.UUID `json:"kepala_keluarga_id,omitempty"`
	ProvinsiID      int        `json:"provinsi_id,omitempty"`
	KotaID          int        `json:"kota_id,omitempty"`
	KecamatanID     int        `json:"kecamatan_id,omitempty"`
	KelurahanID     int        `json:"kelurahan_id,omitempty"`
	RTID            int        `json:"rt_id,omitempty"`
	RWID            int        `json:"rw_id,omitempty"`
	Alamat          string     `json:"alamat,omitempty"`
	KodePos         string     `json:"kode_pos,omitempty" validate:"omitempty,min=5,max=5"`
} 

func (KartuKeluarga) TableName() string {
    return "kartu_keluarga"
}
