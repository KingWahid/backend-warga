import 'package:equatable/equatable.dart';

class Pengajuan extends Equatable {
  final String id;
  final String suratId;
  final String suratNama;
  final String wargaId;
  final String wargaNama;
  final String status;
  final String? alasan;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? approvedBy;
  final DateTime? approvedAt;
  final String? rejectedBy;
  final DateTime? rejectedAt;
  final String? notes;
  final int rtId;
  final String? ttdRtUrl;
  
  const Pengajuan({
    required this.id,
    required this.suratId,
    required this.suratNama,
    required this.wargaId,
    required this.wargaNama,
    required this.status,
    this.alasan,
    required this.createdAt,
    this.updatedAt,
    this.approvedBy,
    this.approvedAt,
    this.rejectedBy,
    this.rejectedAt,
    this.notes,
    required this.rtId,
    this.ttdRtUrl,
  });
  
  @override
  List<Object?> get props => [
    id,
    suratId,
    suratNama,
    wargaId,
    wargaNama,
    status,
    alasan,
    createdAt,
    updatedAt,
    approvedBy,
    approvedAt,
    rejectedBy,
    rejectedAt,
    notes,
    rtId,
    ttdRtUrl,
  ];
  
  Pengajuan copyWith({
    String? id,
    String? suratId,
    String? suratNama,
    String? wargaId,
    String? wargaNama,
    String? status,
    String? alasan,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? approvedBy,
    DateTime? approvedAt,
    String? rejectedBy,
    DateTime? rejectedAt,
    String? notes,
    int? rtId,
    String? ttdRtUrl,
  }) {
    return Pengajuan(
      id: id ?? this.id,
      suratId: suratId ?? this.suratId,
      suratNama: suratNama ?? this.suratNama,
      wargaId: wargaId ?? this.wargaId,
      wargaNama: wargaNama ?? this.wargaNama,
      status: status ?? this.status,
      alasan: alasan ?? this.alasan,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedAt: approvedAt ?? this.approvedAt,
      rejectedBy: rejectedBy ?? this.rejectedBy,
      rejectedAt: rejectedAt ?? this.rejectedAt,
      notes: notes ?? this.notes,
      rtId: rtId ?? this.rtId,
      ttdRtUrl: ttdRtUrl ?? this.ttdRtUrl,
    );
  }
}

class Dokumen extends Equatable {
  final String id;
  final String nama;
  final String url;
  final String tipe;
  final DateTime createdAt;
  
  const Dokumen({
    required this.id,
    required this.nama,
    required this.url,
    required this.tipe,
    required this.createdAt,
  });
  
  @override
  List<Object> get props => [
    id,
    nama,
    url,
    tipe,
    createdAt,
  ];
} 