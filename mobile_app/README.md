# Aplikasi Mobile Warga

Aplikasi mobile Flutter untuk sistem manajemen warga dengan fitur role-based access control.

## Fitur

### Role Kepala Keluarga
- Login dengan NIK dan password
- Melihat data keluarga
- Mengajukan surat/dokumen
- Melihat status pengajuan

### Role RT
- Login dengan kredensial RT
- Melihat daftar warga di RT
- Approval pengajuan surat
- Manajemen data warga

### Role RW
- Login dengan kredensial RW
- Melihat daftar warga di RW
- Approval pengajuan surat level RW
- Monitoring RT

## Teknologi

- **Flutter**: Framework UI
- **BLoC**: State management
- **Clean Architecture**: Arsitektur aplikasi
- **Dio**: HTTP client
- **Shared Preferences**: Local storage
- **Get It**: Dependency injection

## Struktur Project

```
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   └── utils/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── blocs/
│   ├── pages/
│   └── widgets/
└── main.dart
```

## Setup

1. Install dependencies:
```bash
flutter pub get
```

2. Setup environment variables di `lib/core/constants/app_config.dart`

3. Run aplikasi:
```bash
flutter run
```

## API Endpoints

Aplikasi ini mengkonsumsi API dari backend Go yang sudah dibuat sebelumnya. 