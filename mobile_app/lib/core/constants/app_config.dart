class AppConfig {
  // API Configuration
  static const String baseUrl = 'http://localhost:8080/api';
  static const String authUrl = '$baseUrl/auth';
  static const String wargaUrl = '$baseUrl/warga';
  static const String kartuKeluargaUrl = '$baseUrl/kartu-keluarga';
  static const String wilayahUrl = '$baseUrl';
  
  // Timeout
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // Local Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String roleKey = 'user_role';
  
  // App Info
  static const String appName = 'Aplikasi Warga';
  static const String appVersion = '1.0.0';
  
  // Roles
  static const String roleKepalaKeluarga = 'kepalakeluarga';
  static const String roleRT = 'rt';
  static const String roleRW = 'rw';
  
  // Status Pengajuan
  static const String statusPending = 'pending';
  static const String statusApproved = 'approved';
  static const String statusRejected = 'rejected';
} 