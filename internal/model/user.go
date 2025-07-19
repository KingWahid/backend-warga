package model

import (
	"time"

	"github.com/google/uuid"
)

type Role string

const (
	RoleUser           Role = "warga"
	RoleKepalaKeluarga Role = "kepalakeluarga"
	RoleRT             Role = "rt"
	RoleRW             Role = "rw"
	RoleAdmin          Role = "admin"
	RoleSuperAdmin     Role = "superadmin"
)

type User struct {
    Id        uuid.UUID  `gorm:"type:uuid;default:uuid_generate_v4();primaryKey" json:"id"`
    WargaID   *uuid.UUID `gorm:"type:uuid" json:"warga_id,omitempty"`
    Nama      string     `gorm:"type:text;not null" json:"nama"`
    Email     string     `gorm:"type:varchar(100);uniqueIndex;not null" json:"email"`
    Password  string     `gorm:"type:text;not null" json:"-"` // tidak keluar di response JSON
    Role      Role       `gorm:"type:enum_role;not null" json:"role"`
    CreatedAt time.Time  `gorm:"autoCreateTime" json:"created_at"`
    UpdatedAt time.Time  `gorm:"autoUpdateTime" json:"updated_at"`

    // Relasi
    Warga *Warga `gorm:"foreignKey:WargaID;references:ID" json:"warga,omitempty"`
}


