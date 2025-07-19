import '../../domain/entities/warga.dart';
import 'kartu_keluarga_model.dart';

class WargaModel extends Warga {
  const WargaModel({
    required super.id,
    required super.namaLengkap,
    required super.nik,
    required super.noKK,
    required super.tempatLahir,
    required super.tanggalLahir,
    required super.jenisKelamin,
    required super.agama,
    required super.pendidikan,
    required super.jenisPekerjaan,
    super.golonganDarah,
    required super.statusPerkawinan,
    super.tanggalPerkawinan,
    required super.statusKeluarga,
    required super.kewarganegaraan,
    required super.namaAyah,
    required super.namaIbu,
    required super.createdAt,
    required super.updatedAt,
    super.kartuKeluarga,
  });

  factory WargaModel.fromJson(Map<String, dynamic> json) {
    return WargaModel(
      id: json['id'] ?? '',
      namaLengkap: json['nama_lengkap'] ?? '',
      nik: json['nik'] ?? '',
      noKK: json['no_kk'] ?? '',
      tempatLahir: json['tempat_lahir'] ?? '',
      tanggalLahir: DateTime.parse(json['tanggal_lahir'] ?? DateTime.now().toIso8601String()),
      jenisKelamin: json['jenis_kelamin'] ?? '',
      agama: json['agama'] ?? '',
      pendidikan: json['pendidikan'] ?? '',
      jenisPekerjaan: json['jenis_pekerjaan'] ?? '',
      golonganDarah: json['golongan_darah'],
      statusPerkawinan: json['status_perkawinan'] ?? '',
      tanggalPerkawinan: json['tanggal_perkawinan'] != null 
          ? DateTime.parse(json['tanggal_perkawinan'])
          : null,
      statusKeluarga: json['status_keluarga'] ?? '',
      kewarganegaraan: json['kewarganegaraan'] ?? '',
      namaAyah: json['nama_ayah'] ?? '',
      namaIbu: json['nama_ibu'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      kartuKeluarga: json['kartu_keluarga'] != null 
          ? KartuKeluargaModel.fromJson(json['kartu_keluarga'])
          : null,
    );
  }

  factory WargaModel.fromEntity(Warga warga) {
    return WargaModel(
      id: warga.id,
      namaLengkap: warga.namaLengkap,
      nik: warga.nik,
      noKK: warga.noKK,
      tempatLahir: warga.tempatLahir,
      tanggalLahir: warga.tanggalLahir,
      jenisKelamin: warga.jenisKelamin,
      agama: warga.agama,
      pendidikan: warga.pendidikan,
      jenisPekerjaan: warga.jenisPekerjaan,
      golonganDarah: warga.golonganDarah,
      statusPerkawinan: warga.statusPerkawinan,
      tanggalPerkawinan: warga.tanggalPerkawinan,
      statusKeluarga: warga.statusKeluarga,
      kewarganegaraan: warga.kewarganegaraan,
      namaAyah: warga.namaAyah,
      namaIbu: warga.namaIbu,
      createdAt: warga.createdAt,
      updatedAt: warga.updatedAt,
      kartuKeluarga: warga.kartuKeluarga,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_lengkap': namaLengkap,
      'nik': nik,
      'no_kk': noKK,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': tanggalLahir.toIso8601String(),
      'jenis_kelamin': jenisKelamin,
      'agama': agama,
      'pendidikan': pendidikan,
      'jenis_pekerjaan': jenisPekerjaan,
      'golongan_darah': golonganDarah,
      'status_perkawinan': statusPerkawinan,
      'tanggal_perkawinan': tanggalPerkawinan?.toIso8601String(),
      'status_keluarga': statusKeluarga,
      'kewarganegaraan': kewarganegaraan,
      'nama_ayah': namaAyah,
      'nama_ibu': namaIbu,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'kartu_keluarga': kartuKeluarga != null 
          ? (kartuKeluarga as KartuKeluargaModel).toJson() 
          : null,
    };
  }
} 