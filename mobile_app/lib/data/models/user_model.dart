import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.nama,
    required super.role,
    super.wargaId,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      nama: json['nama'] ?? '',
      role: json['role'] ?? '',
      wargaId: json['warga_id'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nama': nama,
      'role': role,
      'warga_id': wargaId,
    };
  }
  
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      nama: user.nama,
      role: user.role,
      wargaId: user.wargaId,
    );
  }
} 