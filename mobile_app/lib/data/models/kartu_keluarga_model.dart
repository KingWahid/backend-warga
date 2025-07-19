import '../../domain/entities/kartu_keluarga.dart';

class KartuKeluargaModel extends KartuKeluarga {
  const KartuKeluargaModel({
    required super.id,
    required super.noKK,
    super.kepalaKeluargaId,
    required super.provinsiId,
    required super.kotaId,
    required super.kecamatanId,
    required super.kelurahanId,
    required super.rtId,
    required super.rwId,
    required super.alamat,
    required super.kodePos,
    required super.createdAt,
    required super.updatedAt,
  });

  factory KartuKeluargaModel.fromJson(Map<String, dynamic> json) {
    return KartuKeluargaModel(
      id: json['id'] ?? '',
      noKK: json['no_kk'] ?? '',
      kepalaKeluargaId: json['kepala_keluarga_id'],
      provinsiId: json['provinsi_id'] ?? 0,
      kotaId: json['kota_id'] ?? 0,
      kecamatanId: json['kecamatan_id'] ?? 0,
      kelurahanId: json['kelurahan_id'] ?? 0,
      rtId: json['rt_id'] ?? 0,
      rwId: json['rw_id'] ?? 0,
      alamat: json['alamat'] ?? '',
      kodePos: json['kode_pos'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  factory KartuKeluargaModel.fromEntity(KartuKeluarga kartuKeluarga) {
    return KartuKeluargaModel(
      id: kartuKeluarga.id,
      noKK: kartuKeluarga.noKK,
      kepalaKeluargaId: kartuKeluarga.kepalaKeluargaId,
      provinsiId: kartuKeluarga.provinsiId,
      kotaId: kartuKeluarga.kotaId,
      kecamatanId: kartuKeluarga.kecamatanId,
      kelurahanId: kartuKeluarga.kelurahanId,
      rtId: kartuKeluarga.rtId,
      rwId: kartuKeluarga.rwId,
      alamat: kartuKeluarga.alamat,
      kodePos: kartuKeluarga.kodePos,
      createdAt: kartuKeluarga.createdAt,
      updatedAt: kartuKeluarga.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'no_kk': noKK,
      'kepala_keluarga_id': kepalaKeluargaId,
      'provinsi_id': provinsiId,
      'kota_id': kotaId,
      'kecamatan_id': kecamatanId,
      'kelurahan_id': kelurahanId,
      'rt_id': rtId,
      'rw_id': rwId,
      'alamat': alamat,
      'kode_pos': kodePos,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
} 