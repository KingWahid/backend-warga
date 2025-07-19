import 'package:equatable/equatable.dart';

class KartuKeluarga extends Equatable {
  final String id;
  final String noKK;
  final String? kepalaKeluargaId;
  final int provinsiId;
  final int kotaId;
  final int kecamatanId;
  final int kelurahanId;
  final int rtId;
  final int rwId;
  final String alamat;
  final String kodePos;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const KartuKeluarga({
    required this.id,
    required this.noKK,
    this.kepalaKeluargaId,
    required this.provinsiId,
    required this.kotaId,
    required this.kecamatanId,
    required this.kelurahanId,
    required this.rtId,
    required this.rwId,
    required this.alamat,
    required this.kodePos,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  List<Object?> get props => [
    id,
    noKK,
    kepalaKeluargaId,
    provinsiId,
    kotaId,
    kecamatanId,
    kelurahanId,
    rtId,
    rwId,
    alamat,
    kodePos,
    createdAt,
    updatedAt,
  ];
} 