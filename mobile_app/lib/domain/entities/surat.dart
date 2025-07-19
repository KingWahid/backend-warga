import 'package:equatable/equatable.dart';

class Surat extends Equatable {
  final String id;
  final String nama;
  final String deskripsi;
  final String template;
  final String requiredFields;
  final String kategori;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const Surat({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.template,
    required this.requiredFields,
    required this.kategori,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  List<Object?> get props => [
    id,
    nama,
    deskripsi,
    template,
    requiredFields,
    kategori,
    createdAt,
    updatedAt,
  ];
} 