# Setup Aplikasi Mobile Warga

## Prerequisites

1. Flutter SDK (versi 3.0.0 atau lebih baru)
2. Android Studio / VS Code
3. Android SDK / Xcode (untuk iOS)
4. Backend API sudah berjalan di `http://localhost:8080`

## Langkah Setup

### 1. Install Dependencies

```bash
cd mobile_app
flutter pub get
```

### 2. Konfigurasi API

Pastikan backend API sudah berjalan dan dapat diakses. Jika backend berjalan di port atau URL yang berbeda, edit file:

```
lib/core/constants/app_config.dart
```

Ubah nilai `baseUrl` sesuai dengan URL backend Anda.

### 3. Run Aplikasi

```bash
# Untuk Android
flutter run

# Untuk iOS
flutter run -d ios

# Untuk web
flutter run -d chrome
```

## Struktur Aplikasi

### Clean Architecture

```
lib/
├── core/                    # Core utilities
│   ├── constants/          # App constants
│   ├── di/                 # Dependency injection
│   ├── errors/             # Error handling
│   └── network/            # Network layer
├── data/                   # Data layer
│   ├── datasources/        # Remote & local data sources
│   ├── models/             # Data models
│   └── repositories/       # Repository implementations
├── domain/                 # Domain layer
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/          # Business logic
└── presentation/           # Presentation layer
    ├── blocs/             # BLoC state management
    ├── pages/             # UI pages
    └── widgets/           # Reusable widgets
```

### Fitur Role-based Access

1. **Kepala Keluarga**
   - Login dengan NIK dan password
   - Melihat data keluarga
   - Mengajukan surat/dokumen
   - Melihat status pengajuan

2. **RT (Rukun Tetangga)**
   - Login dengan kredensial RT
   - Melihat daftar warga di RT
   - Approval pengajuan surat
   - Manajemen data warga

3. **RW (Rukun Warga)**
   - Login dengan kredensial RW
   - Melihat daftar warga di RW
   - Approval pengajuan surat level RW
   - Monitoring RT

## Testing

### Unit Tests

```bash
flutter test
```

### Integration Tests

```bash
flutter test integration_test/
```

## Build

### Android APK

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

## Troubleshooting

### Common Issues

1. **API Connection Error**
   - Pastikan backend berjalan
   - Cek URL di `app_config.dart`
   - Cek firewall/network settings

2. **Dependencies Error**
   - Run `flutter clean`
   - Run `flutter pub get`

3. **Build Error**
   - Update Flutter SDK
   - Cek Android SDK / Xcode
   - Run `flutter doctor`

## Next Steps

1. Implementasi fitur pengajuan surat
2. Implementasi approval system
3. Implementasi upload dokumen
4. Implementasi notifikasi
5. Implementasi offline mode
6. Implementasi push notifications 