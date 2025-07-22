import '../../domain/entities/pengajuan.dart';
import 'warga_model.dart';
import 'surat_model.dart';

class PengajuanModel extends Pengajuan {
  final WargaModel? warga;
  final SuratModel? surat;

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
    required super.rtId,
    super.ttdRtUrl,
    this.warga,
    this.surat,
  });
  
  factory PengajuanModel.fromJson(Map<String, dynamic> json) {
    return PengajuanModel(
      id: json['id'] ?? '',
      suratId: json['surat_id'] ?? '',
      suratNama: json['surat']?['nama'] ?? '-', // akses nested
      wargaId: json['warga_id'] ?? '',
      wargaNama: json['warga']?['nama_lengkap'] ?? '-', // akses nested
      status: json['status'] ?? '',
      alasan: json['alasan'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      approvedBy: json['approved_by'],
      approvedAt: json['approved_at'] != null ? DateTime.parse(json['approved_at']) : null,
      rejectedBy: json['rejected_by'],
      rejectedAt: json['rejected_at'] != null ? DateTime.parse(json['rejected_at']) : null,
      notes: json['notes'],
      rtId: json['rt_id'] ?? 0,
      ttdRtUrl: json['ttd_rt_url'],
      warga: json['warga'] != null ? WargaModel.fromJson(json['warga']) : null,
      surat: json['surat'] != null ? SuratModel.fromJson(json['surat']) : null,
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
      'rt_id': rtId,
      'ttd_rt_url': ttdRtUrl,
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
      rtId: pengajuan.rtId,
      ttdRtUrl: pengajuan.ttdRtUrl,
    );
  }

  Map<String, dynamic> toJsonCreate() {
    return {
      'surat_id': suratId,
      'warga_id': wargaId,
      'rt_id': rtId,
      'alasan': alasan,
    };
  }
} 