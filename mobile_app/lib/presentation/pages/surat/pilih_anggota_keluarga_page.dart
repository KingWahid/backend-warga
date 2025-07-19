import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/surat.dart';
import '../../../domain/entities/warga.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../blocs/warga/warga_bloc.dart';
import '../../blocs/warga/warga_event.dart';
import '../../blocs/warga/warga_state.dart';

class PilihAnggotaKeluargaPage extends StatefulWidget {
  final Surat surat;
  
  const PilihAnggotaKeluargaPage({
    Key? key,
    required this.surat,
  }) : super(key: key);

  @override
  State<PilihAnggotaKeluargaPage> createState() => _PilihAnggotaKeluargaPageState();
}

class _PilihAnggotaKeluargaPageState extends State<PilihAnggotaKeluargaPage> {
  @override
  void initState() {
    super.initState();
    _loadAnggotaKeluarga();
  }

  void _loadAnggotaKeluarga() {
    // Get current user from auth bloc
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      final user = authState.user;
      // Load anggota keluarga using BLoC
      context.read<WargaBloc>().add(LoadAnggotaKeluarga(user.id));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pilih Anggota Keluarga'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppColors.primary.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jenis Surat: ${widget.surat.nama}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pilih anggota keluarga yang akan dibuatkan surat',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: BlocBuilder<WargaBloc, WargaState>(
              builder: (context, state) {
                print('PilihAnggotaKeluargaPage: Current state - $state');
                return _buildContent(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(WargaState state) {
    if (state is WargaLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is WargaError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Terjadi kesalahan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red[300],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadAnggotaKeluarga,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (state is WargaLoaded) {
      if (state.anggotaKeluarga.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.family_restroom_outlined,
                size: 64,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: 16),
              Text(
                'Tidak ada anggota keluarga',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.anggotaKeluarga.length,
        itemBuilder: (context, index) {
          final anggota = state.anggotaKeluarga[index];
          return _buildAnggotaCard(anggota);
        },
      );
    }

    return const Center(
      child: Text('Tidak ada data'),
    );
  }

  Widget _buildAnggotaCard(Warga anggota) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to preview surat page
          context.push('/preview-surat', extra: {
            'surat': widget.surat,
            'warga': anggota,
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: _getStatusColor(anggota.statusKeluarga),
                child: Text(
                  anggota.namaLengkap.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anggota.namaLengkap,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      anggota.statusKeluarga,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'NIK: ${anggota.nik}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textSecondary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String statusKeluarga) {
    switch (statusKeluarga) {
      case 'Kepala Keluarga':
        return AppColors.primary;
      case 'Istri':
        return Colors.pink;
      case 'Suami':
        return Colors.blue;
      case 'Anak':
        return Colors.green;
      default:
        return AppColors.textSecondary;
    }
  }
} 