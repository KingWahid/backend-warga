import '../../domain/entities/surat.dart';

class SuratModel extends Surat {
  const SuratModel({
    required super.id,
    required super.nama,
    required super.deskripsi,
    required super.template,
    required super.requiredFields,
    required super.kategori,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SuratModel.fromJson(Map<String, dynamic> json) {
    return SuratModel(
      id: json['id'] ?? '',
      nama: json['nama'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      template: json['template'] ?? '',
      requiredFields: json['required_fields'] ?? '',
      kategori: json['kategori'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  factory SuratModel.fromEntity(Surat surat) {
    return SuratModel(
      id: surat.id,
      nama: surat.nama,
      deskripsi: surat.deskripsi,
      template: surat.template,
      requiredFields: surat.requiredFields,
      kategori: surat.kategori,
      createdAt: surat.createdAt,
      updatedAt: surat.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'template': template,
      'required_fields': requiredFields,
      'kategori': kategori,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
} 