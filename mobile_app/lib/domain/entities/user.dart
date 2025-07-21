import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String nama;
  final String role;
  final String? wargaId;
  
  const User({
    required this.id,
    required this.email,
    required this.nama,
    required this.role,
    this.wargaId,
  });
  
  @override
  List<Object?> get props => [
    id,
    email,
    nama,
    role,
    wargaId,
  ];
  
  User copyWith({
    String? id,
    String? email,
    String? nama,
    String? role,
    String? wargaId,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      nama: nama ?? this.nama,
      role: role ?? this.role,
      wargaId: wargaId ?? this.wargaId,
    );
  }
} 