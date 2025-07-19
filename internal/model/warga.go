package model

import (
	"time"

	"github.com/google/uuid"
)

type JenisKelamin string
type Agama string
type GolonganDarah string
type StatusPerkawinan string
type StatusKeluarga string

const (
	JenisKelaminLakiLaki   JenisKelamin = "Laki-laki"
	JenisKelaminPerempuan  JenisKelamin = "Perempuan"
	
	AgamaIslam             Agama = "Islam"
	AgamaKristen           Agama = "Kristen"
	AgamaKatolik           Agama = "Katolik"
	AgamaHindu             Agama = "Hindu"
	AgamaBuddha            Agama = "Buddha"
	AgamaKonghucu          Agama = "Konghucu"
	AgamaLainnya           Agama = "Lainnya"
	
	GolonganDarahA         GolonganDarah = "A"
	GolonganDarahB         GolonganDarah = "B"
	GolonganDarahAB        GolonganDarah = "AB"
	GolonganDarahO         GolonganDarah = "O"
	
	StatusPerkawinanBelumKawin StatusPerkawinan = "Belum Kawin"
	StatusPerkawinanKawin      StatusPerkawinan = "Kawin"
	StatusPerkawinanCeraiHidup StatusPerkawinan = "Cerai Hidup"
	StatusPerkawinanCeraiMati  StatusPerkawinan = "Cerai Mati"
	
	StatusKeluargaKepalaKeluarga StatusKeluarga = "Kepala Keluarga"
	StatusKeluargaSuami          StatusKeluarga = "Suami"
	StatusKeluargaIstri          StatusKeluarga = "Istri"
	StatusKeluargaAnak           StatusKeluarga = "Anak"
	StatusKeluargaOrangTua       StatusKeluarga = "Orang Tua"
	StatusKeluargaLainnya        StatusKeluarga = "Lainnya"
)

type Warga struct {
	ID                uuid.UUID       `json:"id" gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	NamaLengkap       string          `json:"nama_lengkap" gorm:"size:100;not null"`
	NIK               string          `json:"nik" gorm:"size:16;uniqueIndex;not null"`
	NoKK              string          `json:"no_kk" gorm:"size:16;not null"`
	TempatLahir       string          `json:"tempat_lahir" gorm:"size:50"`
	TanggalLahir      time.Time       `json:"tanggal_lahir" gorm:"type:date;not null"`
	JenisKelamin      JenisKelamin    `json:"jenis_kelamin" gorm:"type:varchar(20);not null"` // Ubah dari varchar(1) ke varchar(20)
	Agama             Agama           `json:"agama" gorm:"type:varchar(20);not null"`
	Pendidikan        string          `json:"pendidikan" gorm:"size:50"`
	JenisPekerjaan    string          `json:"jenis_pekerjaan" gorm:"size:50"`
	GolonganDarah     *GolonganDarah  `json:"golongan_darah,omitempty" gorm:"type:varchar(2)"`
	StatusPerkawinan  StatusPerkawinan `json:"status_perkawinan" gorm:"type:varchar(20);not null"`
	TanggalPerkawinan *time.Time      `json:"tanggal_perkawinan,omitempty" gorm:"type:date"`
	StatusKeluarga    StatusKeluarga  `json:"status_keluarga" gorm:"type:varchar(20);not null"`
	Kewarganegaraan   string          `json:"kewarganegaraan" gorm:"size:3;not null;default:'WNI'"`
	NamaAyah          string          `json:"nama_ayah" gorm:"size:100"`
	NamaIbu           string          `json:"nama_ibu" gorm:"size:100"`
	CreatedAt         time.Time       `json:"created_at" gorm:"autoCreateTime"`
	UpdatedAt         time.Time       `json:"updated_at" gorm:"autoUpdateTime"`
	KartuKeluarga KartuKeluarga `json:"kartu_keluarga,omitempty" gorm:"foreignKey:NoKK;references:NoKK"`
}

type CreateWargaRequest struct {
	NamaLengkap       string          `json:"nama_lengkap" validate:"required"`
	NIK               string          `json:"nik" validate:"required,min=16,max=16"`
	NoKK              string          `json:"no_kk" validate:"required,min=16,max=16"`
	TempatLahir       string          `json:"tempat_lahir"`
	TanggalLahir      string          `json:"tanggal_lahir" validate:"required"` // Ubah dari time.Time ke string untuk parsing
	JenisKelamin      JenisKelamin    `json:"jenis_kelamin" validate:"required"`
	Agama             Agama           `json:"agama" validate:"required"`
	Pendidikan        string          `json:"pendidikan"`
	JenisPekerjaan    string          `json:"jenis_pekerjaan"`
	GolonganDarah     *GolonganDarah  `json:"golongan_darah,omitempty"`
	StatusPerkawinan  StatusPerkawinan `json:"status_perkawinan" validate:"required"`
	TanggalPerkawinan *string         `json:"tanggal_perkawinan,omitempty"` // Ubah dari *time.Time ke *string
	StatusKeluarga    StatusKeluarga  `json:"status_keluarga" validate:"required"`
	Kewarganegaraan   string          `json:"kewarganegaraan" validate:"required"`
	NamaAyah          string          `json:"nama_ayah"`
	NamaIbu           string          `json:"nama_ibu"`
}

type UpdateWargaRequest struct {
	NamaLengkap       string          `json:"nama_lengkap,omitempty"`
	NIK               string          `json:"nik,omitempty" validate:"omitempty,min=16,max=16"`
	NoKK              string          `json:"no_kk,omitempty" validate:"omitempty,min=16,max=16"`
	TempatLahir       string          `json:"tempat_lahir,omitempty"`
	TanggalLahir      *string         `json:"tanggal_lahir,omitempty"` // Ubah dari *time.Time ke *string
	JenisKelamin      *JenisKelamin   `json:"jenis_kelamin,omitempty"`
	Agama             *Agama          `json:"agama,omitempty"`
	Pendidikan        string          `json:"pendidikan,omitempty"`
	JenisPekerjaan    string          `json:"jenis_pekerjaan,omitempty"`
	GolonganDarah     *GolonganDarah  `json:"golongan_darah,omitempty"`
	StatusPerkawinan  *StatusPerkawinan `json:"status_perkawinan,omitempty"`
	TanggalPerkawinan *string         `json:"tanggal_perkawinan,omitempty"` // Ubah dari *time.Time ke *string
	StatusKeluarga    *StatusKeluarga `json:"status_keluarga,omitempty"`
	Kewarganegaraan   string          `json:"kewarganegaraan,omitempty"`
	NamaAyah          string          `json:"nama_ayah,omitempty"`
	NamaIbu           string          `json:"nama_ibu,omitempty"`
} 

func (Warga) TableName() string {
    return "warga"
}