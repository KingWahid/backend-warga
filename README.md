# Sistem Warga - Backend API

Sistem backend untuk mengelola data warga dan kartu keluarga dengan menggunakan Go, Gin, dan PostgreSQL.

## Fitur

- ✅ Manajemen Kartu Keluarga (CRUD)
- ✅ Manajemen Warga (model sudah dibuat)
- ✅ Manajemen Wilayah (Provinsi, Kota, Kecamatan, Kelurahan)
- ✅ Manajemen RT/RW
- ✅ Validasi input
- ✅ Pagination
- ✅ Error handling yang konsisten

## Struktur Proyek

```
backend-warga/
├── cmd/
│   └── main.go                 # Entry point aplikasi
├── internal/
│   ├── delivery/               # HTTP handlers
│   │   ├── kartu_keluarga_handler.go
│   │   ├── wilayah_handler.go
│   │   ├── rt_handler.go
│   │   └── rw_handler.go
│   ├── model/                  # Data models
│   │   ├── kartu_keluarga.go
│   │   ├── warga.go
│   │   ├── wilayah.go
│   │   ├── rt.go
│   │   └── rw.go
│   ├── repository/             # Data access layer
│   │   ├── kartu_keluarga_repository.go
│   │   ├── wilayah_repository.go
│   │   ├── rt_repository.go
│   │   └── rw_repository.go
│   └── usecase/               # Business logic
│       ├── kartu_keluarga_usecase.go
│       ├── wilayah_usecase.go
│       ├── rt_usecase.go
│       └── rw_usecase.go
├── database/
│   └── migrations/
│       └── 001_create_kartu_keluarga_and_warga.sql
├── API_DOCUMENTATION.md       # Dokumentasi API lengkap
├── go.mod
└── go.sum
```

## Prerequisites

- Go 1.19 atau lebih baru
- PostgreSQL 12 atau lebih baru
- Git

## Instalasi dan Setup

### 1. Clone Repository
```bash
git clone <repository-url>
cd backend-warga
```

### 2. Install Dependencies
```bash
go mod tidy
```

### 3. Setup Database

#### a. Buat Database PostgreSQL
```sql
CREATE DATABASE warga_db;
```

#### b. Jalankan Migration
```bash
psql -d warga_db -f database/migrations/001_create_kartu_keluarga_and_warga.sql
```

### 4. Setup Environment Variables

Buat file `.env` di root directory:

```env
DB_HOST=localhost
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=warga_db
DB_PORT=5432
DB_SSLMODE=disable
```

### 5. Jalankan Aplikasi
```bash
go run cmd/main.go
```

Aplikasi akan berjalan di `http://localhost:8080`

## API Endpoints

### Kartu Keluarga
- `POST /api/kartu-keluarga` - Membuat kartu keluarga baru
- `GET /api/kartu-keluarga` - Mendapatkan semua kartu keluarga (dengan pagination)
- `GET /api/kartu-keluarga/{id}` - Mendapatkan kartu keluarga by ID
- `GET /api/kartu-keluarga/no-kk/{no_kk}` - Mendapatkan kartu keluarga by nomor KK
- `PUT /api/kartu-keluarga/{id}` - Update kartu keluarga
- `DELETE /api/kartu-keluarga/{id}` - Hapus kartu keluarga

### Warga
- `POST /api/warga` - Membuat warga baru
- `GET /api/warga` - Mendapatkan semua warga (dengan pagination)
- `GET /api/warga/{id}` - Mendapatkan warga by ID
- `GET /api/warga/nik/{nik}` - Mendapatkan warga by NIK
- `GET /api/warga/kk/{no_kk}` - Mendapatkan warga by nomor KK
- `GET /api/warga/kepala-keluarga/{no_kk}` - Mendapatkan kepala keluarga by nomor KK
- `GET /api/warga/anggota-keluarga/{no_kk}` - Mendapatkan anggota keluarga by nomor KK
- `PUT /api/warga/{id}` - Update warga
- `DELETE /api/warga/{id}` - Hapus warga

### Wilayah
- `GET /api/provinsi` - Mendapatkan semua provinsi
- `GET /api/kota?provinsi_id={id}` - Mendapatkan kota by provinsi ID
- `GET /api/kecamatan?kota_id={id}` - Mendapatkan kecamatan by kota ID
- `GET /api/kelurahan?kecamatan_id={id}` - Mendapatkan kelurahan by kecamatan ID

### RT/RW
- `POST /api/rt` - Membuat RT baru
- `GET /api/rt?kelurahan_id={id}` - Mendapatkan RT by kelurahan ID
- `POST /api/rw` - Membuat RW baru
- `GET /api/rw?kelurahan_id={id}` - Mendapatkan RW by kelurahan ID

## Contoh Penggunaan

### Membuat Kartu Keluarga Baru
```bash
curl -X POST http://localhost:8080/api/kartu-keluarga \
  -H "Content-Type: application/json" \
  -d '{
    "no_kk": "1234567890123456",
    "provinsi_id": 1,
    "kota_id": 1,
    "kecamatan_id": 1,
    "kelurahan_id": 1,
    "rt_id": 1,
    "rw_id": 1,
    "alamat": "Jl. Contoh No. 123",
    "kode_pos": "12345"
  }'
```

### Mendapatkan Semua Kartu Keluarga
```bash
curl -X GET "http://localhost:8080/api/kartu-keluarga?page=1&limit=10"
```

### Mendapatkan Kartu Keluarga by ID
```bash
curl -X GET http://localhost:8080/api/kartu-keluarga/uuid-here
```

### Update Kartu Keluarga
```bash
curl -X PUT http://localhost:8080/api/kartu-keluarga/uuid-here \
  -H "Content-Type: application/json" \
  -d '{
    "alamat": "Jl. Contoh Baru No. 456",
    "kode_pos": "54321"
  }'
```

### Hapus Kartu Keluarga
```bash
curl -X DELETE http://localhost:8080/api/kartu-keluarga/uuid-here
```

## Contoh Penggunaan Warga

### Membuat Warga Baru
```bash
curl -X POST http://localhost:8080/api/warga \
  -H "Content-Type: application/json" \
  -d '{
    "nama_lengkap": "John Doe",
    "nik": "1234567890123456",
    "no_kk": "1234567890123456",
    "tempat_lahir": "Jakarta",
    "tanggal_lahir": "1990-01-01T00:00:00Z",
    "jenis_kelamin": "L",
    "agama": "Islam",
    "pendidikan": "SMA",
    "jenis_pekerjaan": "Wiraswasta",
    "golongan_darah": "A",
    "status_perkawinan": "Kawin",
    "tanggal_perkawinan": "2015-06-15T00:00:00Z",
    "status_keluarga": "Kepala Keluarga",
    "kewarganegaraan": "WNI",
    "nama_ayah": "Ayah Doe",
    "nama_ibu": "Ibu Doe"
  }'
```

### Mendapatkan Semua Warga
```bash
curl -X GET "http://localhost:8080/api/warga?page=1&limit=10"
```

### Mendapatkan Warga by ID
```bash
curl -X GET http://localhost:8080/api/warga/uuid-here
```

### Mendapatkan Warga by NIK
```bash
curl -X GET http://localhost:8080/api/warga/nik/1234567890123456
```

### Mendapatkan Warga by Nomor KK
```bash
curl -X GET http://localhost:8080/api/warga/kk/1234567890123456
```

### Mendapatkan Kepala Keluarga
```bash
curl -X GET http://localhost:8080/api/warga/kepala-keluarga/1234567890123456
```

### Mendapatkan Anggota Keluarga
```bash
curl -X GET http://localhost:8080/api/warga/anggota-keluarga/1234567890123456
```

### Update Warga
```bash
curl -X PUT http://localhost:8080/api/warga/uuid-here \
  -H "Content-Type: application/json" \
  -d '{
    "nama_lengkap": "John Doe Updated",
    "pendidikan": "S1",
    "jenis_pekerjaan": "PNS"
  }'
```

### Hapus Warga
```bash
curl -X DELETE http://localhost:8080/api/warga/uuid-here
```

## Validasi Input

### Kartu Keluarga
- `no_kk`: Wajib diisi, 16 digit, harus unik
- `provinsi_id`: Wajib dipilih
- `kota_id`: Wajib dipilih
- `kecamatan_id`: Wajib dipilih
- `kelurahan_id`: Wajib dipilih
- `rt_id`: Wajib dipilih
- `rw_id`: Wajib dipilih
- `alamat`: Wajib diisi
- `kode_pos`: Wajib diisi, 5 digit

### Warga
- `nama_lengkap`: Wajib diisi
- `nik`: Wajib diisi, 16 digit, harus unik
- `no_kk`: Wajib diisi, harus sesuai dengan kartu keluarga yang ada
- `tanggal_lahir`: Wajib diisi
- `jenis_kelamin`: Wajib dipilih (L/P)
- `agama`: Wajib dipilih
- `status_perkawinan`: Wajib dipilih
- `status_keluarga`: Wajib dipilih
- `kewarganegaraan`: Wajib diisi
- Hanya boleh ada 1 kepala keluarga per kartu keluarga

## Response Format

### Success Response
```json
{
  "status": "success",
  "message": "Pesan sukses",
  "data": { ... }
}
```

### Error Response
```json
{
  "status": "error",
  "message": "Pesan error"
}
```

## HTTP Status Codes

- `200`: Success
- `201`: Created
- `400`: Bad Request (validasi error)
- `404`: Not Found
- `500`: Internal Server Error

## Database Schema

### Tabel kartu_keluarga
```sql
CREATE TABLE kartu_keluarga (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    no_kk VARCHAR(16) NOT NULL UNIQUE,
    kepala_keluarga_id UUID,
    provinsi_id INT NOT NULL,
    kota_id INT NOT NULL,
    kecamatan_id INT NOT NULL,
    kelurahan_id INT NOT NULL,
    rt_id INT NOT NULL,
    rw_id INT NOT NULL,
    alamat TEXT NOT NULL,
    kode_pos VARCHAR(5) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### Tabel warga
```sql
CREATE TABLE warga (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nama_lengkap VARCHAR(100) NOT NULL,
    nik VARCHAR(16) NOT NULL UNIQUE,
    no_kk VARCHAR(16) NOT NULL,
    tempat_lahir VARCHAR(50),
    tanggal_lahir DATE NOT NULL,
    jenis_kelamin enum_jenis_kelamin NOT NULL,
    agama enum_agama NOT NULL,
    pendidikan VARCHAR(50),
    jenis_pekerjaan VARCHAR(50),
    golongan_darah enum_golongan_darah,
    status_perkawinan enum_status_perkawinan NOT NULL,
    tanggal_perkawinan DATE,
    status_keluarga enum_status_keluarga NOT NULL,
    kewarganegaraan VARCHAR(3) NOT NULL DEFAULT 'WNI',
    nama_ayah VARCHAR(100),
    nama_ibu VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

## Development

### Menjalankan Tests
```bash
go test ./...
```

### Menjalankan dengan Hot Reload (menggunakan air)
```bash
# Install air
go install github.com/cosmtrek/air@latest

# Jalankan dengan air
air
```

### Build untuk Production
```bash
go build -o bin/warga-api cmd/main.go
```

## Contributing

1. Fork repository
2. Buat feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add some amazing feature'`)
4. Push ke branch (`git push origin feature/amazing-feature`)
5. Buat Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Support

Jika ada pertanyaan atau masalah, silakan buat issue di repository ini. 