package model

type Provinsi struct {
	ID   uint   `gorm:"primaryKey" json:"id"`
	Nama string `gorm:"size:100" json:"nama"`
}

type Kota struct {
	ID         uint   `gorm:"primaryKey" json:"id"`
	ProvinsiID uint   `json:"provinsi_id"`
	Nama       string `gorm:"size:100" json:"nama"`
}

type Kecamatan struct {
	ID     uint   `gorm:"primaryKey" json:"id"`
	KotaID uint   `json:"kota_id"`
	Nama   string `gorm:"size:100" json:"nama"`
}

type Kelurahan struct {
	ID          uint   `gorm:"primaryKey" json:"id"`
	KecamatanID uint   `json:"kecamatan_id"`
	Nama        string `gorm:"size:100" json:"nama"`
}

func (Provinsi) TableName() string {
    return "provinsi"
}

func (Kota) TableName() string {
    return "kota"
}

func (Kecamatan) TableName() string {
    return "kecamatan"
}

func (Kelurahan) TableName() string {
    return "kelurahan"
}

