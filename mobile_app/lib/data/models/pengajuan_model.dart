import '../../domain/entities/pengajuan.dart';

class PengajuanModel extends Pengajuan {
  const PengajuanModel({
    required super.id,
    required super.suratId,
    required super.suratNama,
    required super.wargaId,
    required super.wargaNama,
    required super.status,
    super.alasan,
    required super.createdAt,
    super.updatedAt,
    super.approvedBy,
    super.approvedAt,
    super.rejectedBy,
    super.rejectedAt,
    super.notes,
  });
  
  factory PengajuanModel.fromJson(Map<String, dynamic> json) {
    return PengajuanModel(
      id: json['id'] ?? '',
      suratId: json['surat_id'] ?? '',
      suratNama: json['surat_nama'] ?? '',
      wargaId: json['warga_id'] ?? '',
      wargaNama: json['warga_nama'] ?? '',
      status: json['status'] ?? '',
      alasan: json['alasan'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      approvedBy: json['approved_by'],
      approvedAt: json['approved_at'] != null ? DateTime.parse(json['approved_at']) : null,
      rejectedBy: json['rejected_by'],
      rejectedAt: json['rejected_at'] != null ? DateTime.parse(json['rejected_at']) : null,
      notes: json['notes'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surat_id': suratId,
      'surat_nama': suratNama,
      'warga_id': wargaId,
      'warga_nama': wargaNama,
      'status': status,
      'alasan': alasan,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'approved_by': approvedBy,
      'approved_at': approvedAt?.toIso8601String(),
      'rejected_by': rejectedBy,
      'rejected_at': rejectedAt?.toIso8601String(),
      'notes': notes,
    };
  }
  
  factory PengajuanModel.fromEntity(Pengajuan pengajuan) {
    return PengajuanModel(
      id: pengajuan.id,
      suratId: pengajuan.suratId,
      suratNama: pengajuan.suratNama,
      wargaId: pengajuan.wargaId,
      wargaNama: pengajuan.wargaNama,
      status: pengajuan.status,
      alasan: pengajuan.alasan,
      createdAt: pengajuan.createdAt,
      updatedAt: pengajuan.updatedAt,
      approvedBy: pengajuan.approvedBy,
      approvedAt: pengajuan.approvedAt,
      rejectedBy: pengajuan.rejectedBy,
      rejectedAt: pengajuan.rejectedAt,
      notes: pengajuan.notes,
    );
  }
} 