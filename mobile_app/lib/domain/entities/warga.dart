import 'package:equatable/equatable.dart';
import '../../domain/entities/kartu_keluarga.dart';
import '../../domain/entities/warga.dart';


class Warga extends Equatable {
  final String id;
  final String namaLengkap;
  final String nik;
  final String noKK;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final String jenisKelamin;
  final String agama;
  final String pendidikan;
  final String jenisPekerjaan;
  final String? golonganDarah;
  final String statusPerkawinan;
  final DateTime? tanggalPerkawinan;
  final String statusKeluarga;
  final String kewarganegaraan;
  final String namaAyah;
  final String namaIbu;
  final DateTime createdAt;
  final DateTime updatedAt;
  final KartuKeluarga? kartuKeluarga;
  
  const Warga({
    required this.id,
    required this.namaLengkap,
    required this.nik,
    required this.noKK,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.agama,
    required this.pendidikan,
    required this.jenisPekerjaan,
    this.golonganDarah,
    required this.statusPerkawinan,
    this.tanggalPerkawinan,
    required this.statusKeluarga,
    required this.kewarganegaraan,
    required this.namaAyah,
    required this.namaIbu,
    required this.createdAt,
    required this.updatedAt,
    this.kartuKeluarga,
  });
  
  @override
  List<Object?> get props => [
    id,
    namaLengkap,
    nik,
    noKK,
    tempatLahir,
    tanggalLahir,
    jenisKelamin,
    agama,
    pendidikan,
    jenisPekerjaan,
    golonganDarah,
    statusPerkawinan,
    tanggalPerkawinan,
    statusKeluarga,
    kewarganegaraan,
    namaAyah,
    namaIbu,
    createdAt,
    updatedAt,
    kartuKeluarga,
  ];
} 