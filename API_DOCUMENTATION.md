# API Documentation - Backend Warga

## Base URL
```
http://localhost:8080/api
```

## Authentication

### Login
**POST** `/auth/login`

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response Success (200):**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response Error (401):**
```json
{
  "error": "invalid credentials",
  "detail": "user not found"
}
```

### Register
**POST** `/auth/register`

**Request Body:**
```json
{
  "nama": "John Doe",
  "email": "john@example.com",
  "password": "password123",
  "role": "user"
}
```

**Response Success (201):**
```json
{
  "message": "user registered successfully"
}
```

### Get Profile
**GET** `/profile`

**Headers:**
```
Authorization: Bearer <access_token>
```

**Response Success (200):**
```json
{
  "id": "uuid-here",
  "nama": "John Doe",
  "email": "john@example.com",
  "role": "user",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z"
}
```

## Endpoint Kartu Keluarga

### 1. Membuat Kartu Keluarga Baru
**POST** `/kartu-keluarga`

**Request Body:**
```json
{
  "no_kk": "1234567890123456",
  "kepala_keluarga_id": "uuid-kepala-keluarga-optional",
  "provinsi_id": 1,
  "kota_id": 1,
  "kecamatan_id": 1,
  "kelurahan_id": 1,
  "rt_id": 1,
  "rw_id": 1,
  "alamat": "Jl. Contoh No. 123",
  "kode_pos": "12345"
}
```

**Response Success (201):**
```json
{
  "status": "success",
  "message": "Kartu keluarga berhasil dibuat",
  "data": {
    "id": "uuid-generated",
    "no_kk": "1234567890123456",
    "kepala_keluarga_id": null,
    "provinsi_id": 1,
    "kota_id": 1,
    "kecamatan_id": 1,
    "kelurahan_id": 1,
    "rt_id": 1,
    "rw_id": 1,
    "alamat": "Jl. Contoh No. 123",
    "kode_pos": "12345",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

**Response Error (400):**
```json
{
  "status": "error",
  "message": "Nomor KK wajib diisi"
}
```

### 2. Mendapatkan Semua Kartu Keluarga
**GET** `/kartu-keluarga`

**Query Parameters:**
- `page` (optional): Halaman yang diminta (default: 1)
- `limit` (optional): Jumlah data per halaman (default: 10, max: 100)

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Daftar kartu keluarga berhasil diambil",
  "data": {
    "kartu_keluargas": [
      {
        "id": "uuid-1",
        "no_kk": "1234567890123456",
        "kepala_keluarga_id": null,
        "provinsi_id": 1,
        "kota_id": 1,
        "kecamatan_id": 1,
        "kelurahan_id": 1,
        "rt_id": 1,
        "rw_id": 1,
        "alamat": "Jl. Contoh No. 123",
        "kode_pos": "12345",
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": 1,
      "total_page": 1
    }
  }
}
```

### 3. Mendapatkan Kartu Keluarga by ID
**GET** `/kartu-keluarga/{id}`

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Kartu keluarga ditemukan",
  "data": {
    "id": "uuid-1",
    "no_kk": "1234567890123456",
    "kepala_keluarga_id": null,
    "provinsi_id": 1,
    "kota_id": 1,
    "kecamatan_id": 1,
    "kelurahan_id": 1,
    "rt_id": 1,
    "rw_id": 1,
    "alamat": "Jl. Contoh No. 123",
    "kode_pos": "12345",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

**Response Error (404):**
```json
{
  "status": "error",
  "message": "kartu keluarga tidak ditemukan"
}
```

### 4. Mendapatkan Kartu Keluarga by Nomor KK
**GET** `/kartu-keluarga/no-kk/{no_kk}`

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Kartu keluarga ditemukan",
  "data": {
    "id": "uuid-1",
    "no_kk": "1234567890123456",
    "kepala_keluarga_id": null,
    "provinsi_id": 1,
    "kota_id": 1,
    "kecamatan_id": 1,
    "kelurahan_id": 1,
    "rt_id": 1,
    "rw_id": 1,
    "alamat": "Jl. Contoh No. 123",
    "kode_pos": "12345",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

### 5. Update Kartu Keluarga
**PUT** `/kartu-keluarga/{id}`

**Request Body:**
```json
{
  "no_kk": "1234567890123457",
  "kepala_keluarga_id": "uuid-kepala-keluarga",
  "provinsi_id": 2,
  "kota_id": 2,
  "kecamatan_id": 2,
  "kelurahan_id": 2,
  "rt_id": 2,
  "rw_id": 2,
  "alamat": "Jl. Contoh Baru No. 456",
  "kode_pos": "54321"
}
```

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Kartu keluarga berhasil diperbarui",
  "data": {
    "id": "uuid-1",
    "no_kk": "1234567890123457",
    "kepala_keluarga_id": "uuid-kepala-keluarga",
    "provinsi_id": 2,
    "kota_id": 2,
    "kecamatan_id": 2,
    "kelurahan_id": 2,
    "rt_id": 2,
    "rw_id": 2,
    "alamat": "Jl. Contoh Baru No. 456",
    "kode_pos": "54321",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T01:00:00Z"
  }
}
```

### 6. Hapus Kartu Keluarga
**DELETE** `/kartu-keluarga/{id}`

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Kartu keluarga berhasil dihapus"
}
```

## Endpoint Warga

### 1. Membuat Warga Baru
**POST** `/warga`

**Request Body:**
```json
{
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
}
```

**Response Success (201):**
```json
{
  "status": "success",
  "message": "Warga berhasil ditambahkan",
  "data": {
    "id": "uuid-generated",
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
    "nama_ibu": "Ibu Doe",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

### 2. Mendapatkan Semua Warga
**GET** `/warga`

**Query Parameters:**
- `page` (optional): Halaman yang diminta (default: 1)
- `limit` (optional): Jumlah data per halaman (default: 10, max: 100)

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Daftar warga berhasil diambil",
  "data": {
    "wargas": [
      {
        "id": "uuid-1",
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
        "nama_ibu": "Ibu Doe",
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": 1,
      "total_page": 1
    }
  }
}
```

### 3. Mendapatkan Warga by ID
**GET** `/warga/{id}`

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Warga ditemukan",
  "data": {
    "id": "uuid-1",
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
    "nama_ibu": "Ibu Doe",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

### 4. Mendapatkan Warga by NIK
**GET** `/warga/nik/{nik}`

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Warga ditemukan",
  "data": {
    "id": "uuid-1",
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
    "nama_ibu": "Ibu Doe",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

### 5. Mendapatkan Warga by Nomor KK
**GET** `/warga/kk/{no_kk}`

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Daftar warga berhasil diambil",
  "data": {
    "wargas": [
      {
        "id": "uuid-1",
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
        "nama_ibu": "Ibu Doe",
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z"
      }
    ],
    "total": 1
  }
}
```

### 6. Mendapatkan Kepala Keluarga by Nomor KK
**GET** `/warga/kepala-keluarga/{no_kk}`

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Kepala keluarga ditemukan",
  "data": {
    "id": "uuid-1",
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
    "nama_ibu": "Ibu Doe",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

### 7. Mendapatkan Anggota Keluarga by Nomor KK
**GET** `/warga/anggota-keluarga/{no_kk}`

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Anggota keluarga berhasil diambil",
  "data": {
    "anggota_keluarga": [
      {
        "id": "uuid-1",
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
        "nama_ibu": "Ibu Doe",
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z"
      }
    ],
    "total": 1
  }
}
```

### 8. Update Warga
**PUT** `/warga/{id}`

**Request Body:**
```json
{
  "nama_lengkap": "John Doe Updated",
  "pendidikan": "S1",
  "jenis_pekerjaan": "PNS"
}
```

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Warga berhasil diperbarui",
  "data": {
    "id": "uuid-1",
    "nama_lengkap": "John Doe Updated",
    "nik": "1234567890123456",
    "no_kk": "1234567890123456",
    "tempat_lahir": "Jakarta",
    "tanggal_lahir": "1990-01-01T00:00:00Z",
    "jenis_kelamin": "L",
    "agama": "Islam",
    "pendidikan": "S1",
    "jenis_pekerjaan": "PNS",
    "golongan_darah": "A",
    "status_perkawinan": "Kawin",
    "tanggal_perkawinan": "2015-06-15T00:00:00Z",
    "status_keluarga": "Kepala Keluarga",
    "kewarganegaraan": "WNI",
    "nama_ayah": "Ayah Doe",
    "nama_ibu": "Ibu Doe",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T01:00:00Z"
  }
}
```

### 9. Hapus Warga
**DELETE** `/warga/{id}`

**Response Success (200):**
```json
{
  "status": "success",
  "message": "Warga berhasil dihapus"
}
```

## Endpoint Wilayah (Sudah Ada)

### 1. Mendapatkan Semua Provinsi
**GET** `/provinsi`

### 2. Mendapatkan Kota by Provinsi ID
**GET** `/kota?provinsi_id={id}`

### 3. Mendapatkan Kecamatan by Kota ID
**GET** `/kecamatan?kota_id={id}`

### 4. Mendapatkan Kelurahan by Kecamatan ID
**GET** `/kelurahan?kecamatan_id={id}`

## Endpoint RT/RW (Sudah Ada)

### 1. Membuat RT
**POST** `/rt`

### 2. Mendapatkan RT by Kelurahan ID
**GET** `/rt?kelurahan_id={id}`

### 3. Membuat RW
**POST** `/rw`

### 4. Mendapatkan RW by Kelurahan ID
**GET** `/rw?kelurahan_id={id}`

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
- `jenis_kelamin`: Wajib dipilih (Laki-laki/Perempuan)
- `agama`: Wajib dipilih
- `status_perkawinan`: Wajib dipilih
- `status_keluarga`: Wajib dipilih
- `kewarganegaraan`: Wajib diisi
- Hanya boleh ada 1 kepala keluarga per kartu keluarga

## Error Handling

Semua endpoint mengembalikan response dengan format yang konsisten:

**Success Response:**
```json
{
  "status": "success",
  "message": "Pesan sukses",
  "data": { ... }
}
```

**Error Response:**
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

## Endpoint Surat

### 1. Mendapatkan Semua Surat
**GET** `/surat`

**Response Success (200):**
```json
[
  {
    "id": "uuid-1",
    "nama": "Surat Keterangan Domisili",
    "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi",
    "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
    "required_fields": ["nama", "nik", "alamat"],
    "kategori": "Administrasi",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
]
```

### 2. Mendapatkan Surat by ID
**GET** `/surat/{id}`

**Response Success (200):**
```json
{
  "id": "uuid-1",
  "nama": "Surat Keterangan Domisili",
  "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi",
  "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
  "required_fields": ["nama", "nik", "alamat"],
  "kategori": "Administrasi",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z"
}
```

### 3. Membuat Surat Baru
**POST** `/surat`

**Request Body:**
```json
{
  "nama": "Surat Keterangan Domisili",
  "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi",
  "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
  "required_fields": ["nama", "nik", "alamat"],
  "kategori": "Administrasi"
}
```

**Response Success (201):**
```json
{
  "id": "uuid-generated",
  "nama": "Surat Keterangan Domisili",
  "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi",
  "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
  "required_fields": ["nama", "nik", "alamat"],
  "kategori": "Administrasi",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z"
}
```

### 4. Update Surat
**PUT** `/surat/{id}`

**Request Body:**
```json
{
  "nama": "Surat Keterangan Domisili Updated",
  "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi (updated)",
  "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
  "required_fields": ["nama", "nik", "alamat"],
  "kategori": "Administrasi"
}
```

**Response Success (200):**
```json
{
  "id": "uuid-1",
  "nama": "Surat Keterangan Domisili Updated",
  "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi (updated)",
  "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
  "required_fields": ["nama", "nik", "alamat"],
  "kategori": "Administrasi",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T01:00:00Z"
}
```

### 5. Hapus Surat
**DELETE** `/surat/{id}`

**Response Success (200):**
```json
{
  "message": "Surat deleted successfully"
}
```

## Endpoint Pengajuan

### 1. Mendapatkan Semua Pengajuan
**GET** `/pengajuan`

**Response Success (200):**
```json
[
  {
    "id": "uuid-1",
    "surat_id": "uuid-surat",
    "surat": {
      "id": "uuid-surat",
      "nama": "Surat Keterangan Domisili",
      "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi",
      "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
      "required_fields": ["nama", "nik", "alamat"],
      "kategori": "Administrasi",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    },
    "warga_id": "uuid-warga",
    "warga": {
      "id": "uuid-warga",
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
      "nama_ibu": "Ibu Doe",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    },
    "status": "pending",
    "alasan": "Untuk keperluan administrasi",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z",
    "approved_by": null,
    "approved_at": null,
    "rejected_by": null,
    "rejected_at": null,
    "notes": null
  }
]
```

### 2. Mendapatkan Pengajuan by ID
**GET** `/pengajuan/{id}`

**Response Success (200):**
```json
{
  "id": "uuid-1",
  "surat_id": "uuid-surat",
  "surat": {
    "id": "uuid-surat",
    "nama": "Surat Keterangan Domisili",
    "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi",
    "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
    "required_fields": ["nama", "nik", "alamat"],
    "kategori": "Administrasi",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  },
  "warga_id": "uuid-warga",
  "warga": {
    "id": "uuid-warga",
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
    "nama_ibu": "Ibu Doe",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  },
  "status": "pending",
  "alasan": "Untuk keperluan administrasi",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z",
  "approved_by": null,
  "approved_at": null,
  "rejected_by": null,
  "rejected_at": null,
  "notes": null
}
```

### 3. Mendapatkan Pengajuan by Warga ID
**GET** `/pengajuan/warga/{warga_id}`

**Response Success (200):**
```json
[
  {
    "id": "uuid-1",
    "surat_id": "uuid-surat",
    "surat": {
      "id": "uuid-surat",
      "nama": "Surat Keterangan Domisili",
      "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi",
      "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
      "required_fields": ["nama", "nik", "alamat"],
      "kategori": "Administrasi",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    },
    "warga_id": "uuid-warga",
    "warga": {
      "id": "uuid-warga",
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
      "nama_ibu": "Ibu Doe",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    },
    "status": "pending",
    "alasan": "Untuk keperluan administrasi",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z",
    "approved_by": null,
    "approved_at": null,
    "rejected_by": null,
    "rejected_at": null,
    "notes": null
  }
]
```

### 4. Mendapatkan Pengajuan by Status
**GET** `/pengajuan/status/{status}`

**Response Success (200):**
```json
[
  {
    "id": "uuid-1",
    "surat_id": "uuid-surat",
    "surat": {
      "id": "uuid-surat",
      "nama": "Surat Keterangan Domisili",
      "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi",
      "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
      "required_fields": ["nama", "nik", "alamat"],
      "kategori": "Administrasi",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    },
    "warga_id": "uuid-warga",
    "warga": {
      "id": "uuid-warga",
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
      "nama_ibu": "Ibu Doe",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    },
    "status": "pending",
    "alasan": "Untuk keperluan administrasi",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z",
    "approved_by": null,
    "approved_at": null,
    "rejected_by": null,
    "rejected_at": null,
    "notes": null
  }
]
```

### 5. Membuat Pengajuan Baru
**POST** `/pengajuan`

**Request Body:**
```json
{
  "surat_id": "uuid-surat",
  "warga_id": "uuid-warga",
  "alasan": "Untuk keperluan administrasi"
}
```

**Response Success (201):**
```json
{
  "id": "uuid-generated",
  "surat_id": "uuid-surat",
  "surat": {
    "id": "uuid-surat",
    "nama": "Surat Keterangan Domisili",
    "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi",
    "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
    "required_fields": ["nama", "nik", "alamat"],
    "kategori": "Administrasi",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  },
  "warga_id": "uuid-warga",
  "warga": {
    "id": "uuid-warga",
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
    "nama_ibu": "Ibu Doe",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  },
  "status": "pending",
  "alasan": "Untuk keperluan administrasi",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z",
  "approved_by": null,
  "approved_at": null,
  "rejected_by": null,
  "rejected_at": null,
  "notes": null
}
```

### 6. Update Pengajuan
**PUT** `/pengajuan/{id}`

**Request Body:**
```json
{
  "surat_id": "uuid-surat",
  "warga_id": "uuid-warga",
  "alasan": "Untuk keperluan administrasi (updated)"
}
```

**Response Success (200):**
```json
{
  "id": "uuid-1",
  "surat_id": "uuid-surat",
  "surat": {
    "id": "uuid-surat",
    "nama": "Surat Keterangan Domisili",
    "deskripsi": "Surat keterangan tempat tinggal untuk keperluan administrasi",
    "template": "SURAT KETERANGAN DOMISILI\n\nYang bertanda tangan di bawah ini:\nNama: {nama}\nNIK: {nik}\nAlamat: {alamat}\n\nMenerangkan bahwa yang bersangkutan benar-benar berdomisili di alamat tersebut.",
    "required_fields": ["nama", "nik", "alamat"],
    "kategori": "Administrasi",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  },
  "warga_id": "uuid-warga",
  "warga": {
    "id": "uuid-warga",
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
    "nama_ibu": "Ibu Doe",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  },
  "status": "pending",
  "alasan": "Untuk keperluan administrasi (updated)",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T01:00:00Z",
  "approved_by": null,
  "approved_at": null,
  "rejected_by": null,
  "rejected_at": null,
  "notes": null
}
```

### 7. Hapus Pengajuan
**DELETE** `/pengajuan/{id}`

**Response Success (200):**
```json
{
  "message": "Pengajuan deleted successfully"
}
```

### 8. Approve Pengajuan
**PUT** `/pengajuan/{id}/approve?approved_by={user_id}`

**Response Success (200):**
```json
{
  "message": "Pengajuan approved successfully"
}
```

### 9. Reject Pengajuan
**PUT** `/pengajuan/{id}/reject?rejected_by={user_id}&reason={reason}`

**Response Success (200):**
```json
{
  "message": "Pengajuan rejected successfully"
}
``` 