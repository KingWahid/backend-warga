-- Insert sample surat data
INSERT INTO surat (id, nama, deskripsi, template, required_fields, kategori, created_at, updated_at) VALUES
(
    gen_random_uuid(),
    'Surat Keterangan Domisili',
    'Surat keterangan domisili untuk keperluan administrasi',
    'Yang bertanda tangan di bawah ini, Lurah Kebangunan, Kecamatan Jakarta Selatan, Kota Jakarta, menerangkan bahwa:

Nama: {{NAMA_LENGKAP}}
NIK: {{NIK}}
No. KK: {{NO_KK}}
Tempat/Tanggal Lahir: {{TEMPAT_LAHIR}}, {{TANGGAL_LAHIR}}
Jenis Kelamin: {{JENIS_KELAMIN}}
Agama: {{AGAMA}}
Pendidikan: {{PENDIDIKAN}}
Jenis Pekerjaan: {{JENIS_PEKERJAAN}}
Golongan Darah: {{GOLONGAN_DARAH}}
Status Perkawinan: {{STATUS_PERKAWINAN}}
Status dalam Keluarga: {{STATUS_KELUARGA}}
Kewarganegaraan: {{KEWARGANEGARAAN}}
Nama Ayah: {{NAMA_AYAH}}
Nama Ibu: {{NAMA_IBU}}

Adalah benar-benar warga yang berdomisili di Kelurahan Kebangunan, Kecamatan Jakarta Selatan, Kota Jakarta.

Surat keterangan ini dibuat untuk keperluan administrasi dan berlaku sampai dengan tanggal {{TANGGAL_SURAT}}.',
    '["nama_lengkap", "nik", "no_kk", "tempat_lahir", "tanggal_lahir", "jenis_kelamin", "agama", "pendidikan", "jenis_pekerjaan", "golongan_darah", "status_perkawinan", "status_keluarga", "kewarganegaraan", "nama_ayah", "nama_ibu"]',
    'Keterangan',
    NOW(),
    NOW()
),
(
    gen_random_uuid(),
    'Surat Keterangan Usaha',
    'Surat keterangan usaha untuk keperluan perizinan',
    'Yang bertanda tangan di bawah ini, Lurah Kebangunan, Kecamatan Jakarta Selatan, Kota Jakarta, menerangkan bahwa:

Nama: {{NAMA_LENGKAP}}
NIK: {{NIK}}
No. KK: {{NO_KK}}
Tempat/Tanggal Lahir: {{TEMPAT_LAHIR}}, {{TANGGAL_LAHIR}}
Jenis Kelamin: {{JENIS_KELAMIN}}
Agama: {{AGAMA}}
Pendidikan: {{PENDIDIKAN}}
Jenis Pekerjaan: {{JENIS_PEKERJAAN}}
Golongan Darah: {{GOLONGAN_DARAH}}
Status Perkawinan: {{STATUS_PERKAWINAN}}
Status dalam Keluarga: {{STATUS_KELUARGA}}
Kewarganegaraan: {{KEWARGANEGARAAN}}
Nama Ayah: {{NAMA_AYAH}}
Nama Ibu: {{NAMA_IBU}}

Adalah benar-benar warga yang berdomisili di Kelurahan Kebangunan, Kecamatan Jakarta Selatan, Kota Jakarta dan memiliki usaha yang sah.

Surat keterangan ini dibuat untuk keperluan perizinan usaha dan berlaku sampai dengan tanggal {{TANGGAL_SURAT}}.',
    '["nama_lengkap", "nik", "no_kk", "tempat_lahir", "tanggal_lahir", "jenis_kelamin", "agama", "pendidikan", "jenis_pekerjaan", "golongan_darah", "status_perkawinan", "status_keluarga", "kewarganegaraan", "nama_ayah", "nama_ibu"]',
    'Usaha',
    NOW(),
    NOW()
),
(
    gen_random_uuid(),
    'Surat Keterangan Tidak Mampu',
    'Surat keterangan tidak mampu untuk keperluan bantuan sosial',
    'Yang bertanda tangan di bawah ini, Lurah Kebangunan, Kecamatan Jakarta Selatan, Kota Jakarta, menerangkan bahwa:

Nama: {{NAMA_LENGKAP}}
NIK: {{NIK}}
No. KK: {{NO_KK}}
Tempat/Tanggal Lahir: {{TEMPAT_LAHIR}}, {{TANGGAL_LAHIR}}
Jenis Kelamin: {{JENIS_KELAMIN}}
Agama: {{AGAMA}}
Pendidikan: {{PENDIDIKAN}}
Jenis Pekerjaan: {{JENIS_PEKERJAAN}}
Golongan Darah: {{GOLONGAN_DARAH}}
Status Perkawinan: {{STATUS_PERKAWINAN}}
Status dalam Keluarga: {{STATUS_KELUARGA}}
Kewarganegaraan: {{KEWARGANEGARAAN}}
Nama Ayah: {{NAMA_AYAH}}
Nama Ibu: {{NAMA_IBU}}

Adalah benar-benar warga yang berdomisili di Kelurahan Kebangunan, Kecamatan Jakarta Selatan, Kota Jakarta dan termasuk dalam kategori tidak mampu.

Surat keterangan ini dibuat untuk keperluan bantuan sosial dan berlaku sampai dengan tanggal {{TANGGAL_SURAT}}.',
    '["nama_lengkap", "nik", "no_kk", "tempat_lahir", "tanggal_lahir", "jenis_kelamin", "agama", "pendidikan", "jenis_pekerjaan", "golongan_darah", "status_perkawinan", "status_keluarga", "kewarganegaraan", "nama_ayah", "nama_ibu"]',
    'Sosial',
    NOW(),
    NOW()
),
(
    gen_random_uuid(),
    'Surat Keterangan Kelahiran',
    'Surat keterangan kelahiran untuk keperluan administrasi kependudukan',
    'Yang bertanda tangan di bawah ini, Lurah Kebangunan, Kecamatan Jakarta Selatan, Kota Jakarta, menerangkan bahwa:

Nama: {{NAMA_LENGKAP}}
NIK: {{NIK}}
No. KK: {{NO_KK}}
Tempat/Tanggal Lahir: {{TEMPAT_LAHIR}}, {{TANGGAL_LAHIR}}
Jenis Kelamin: {{JENIS_KELAMIN}}
Agama: {{AGAMA}}
Pendidikan: {{PENDIDIKAN}}
Jenis Pekerjaan: {{JENIS_PEKERJAAN}}
Golongan Darah: {{GOLONGAN_DARAH}}
Status Perkawinan: {{STATUS_PERKAWINAN}}
Status dalam Keluarga: {{STATUS_KELUARGA}}
Kewarganegaraan: {{KEWARGANEGARAAN}}
Nama Ayah: {{NAMA_AYAH}}
Nama Ibu: {{NAMA_IBU}}

Adalah benar-benar warga yang berdomisili di Kelurahan Kebangunan, Kecamatan Jakarta Selatan, Kota Jakarta dan telah melahirkan anak.

Surat keterangan ini dibuat untuk keperluan administrasi kependudukan dan berlaku sampai dengan tanggal {{TANGGAL_SURAT}}.',
    '["nama_lengkap", "nik", "no_kk", "tempat_lahir", "tanggal_lahir", "jenis_kelamin", "agama", "pendidikan", "jenis_pekerjaan", "golongan_darah", "status_perkawinan", "status_keluarga", "kewarganegaraan", "nama_ayah", "nama_ibu"]',
    'Kependudukan',
    NOW(),
    NOW()
); 