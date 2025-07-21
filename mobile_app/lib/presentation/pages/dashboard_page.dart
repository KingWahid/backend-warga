import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_config.dart';
import '../../domain/entities/user.dart';
import 'rt/pengajuan_rt_page.dart'; // Import sesuai path file Anda
import '../../data/services/rt_helper.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return _buildDashboard(context, state.user);
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildDashboard(BuildContext context, User user) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Dashboard - ${user.nama}'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Card
            _buildUserInfoCard(user),
            const SizedBox(height: 24),
            
            // Role-based Features
            _buildRoleBasedFeatures(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(User user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: _getRoleColor(user.role),
                  child: Icon(
                    _getRoleIcon(user.role),
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.nama,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getRoleColor(user.role).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getRoleDisplayName(user.role),
                          style: TextStyle(
                            color: _getRoleColor(user.role),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Email', user.email),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleBasedFeatures(BuildContext context, User user) {
    switch (user.role) {
      case AppConfig.roleKepalaKeluarga:
        return _buildKepalaKeluargaFeatures(context, user);
      case AppConfig.roleRT:
        return _buildRTFeatures(context, user);
      case AppConfig.roleRW:
        return _buildRWFeatures(context, user);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildKepalaKeluargaFeatures(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fitur Kepala Keluarga',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(
              context,
              'Data Keluarga',
              Icons.family_restroom,
              AppColors.kepalaKeluarga,
              () {
                // TODO: Navigate to family data page
              },
            ),
            _buildFeatureCard(
              context,
              'Ajukan Surat',
              Icons.description,
              AppColors.kepalaKeluarga,
              () {
                context.go('/pilih-jenis-surat');
              },
            ),
            _buildFeatureCard(
              context,
              'Status Pengajuan',
              Icons.pending_actions,
              AppColors.kepalaKeluarga,
              () {
                // TODO: Navigate to application status page
              },
            ),
            _buildFeatureCard(
              context,
              'Profil',
              Icons.person,
              AppColors.kepalaKeluarga,
              () {
                // TODO: Navigate to profile page
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRTFeatures(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fitur RT',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(
              context,
              'Data Warga',
              Icons.people,
              AppColors.rt,
              () {
                // TODO: Navigate to warga data page
              },
            ),
            _buildFeatureCard(
              context,
              'Approval Pengajuan',
              Icons.approval,
              AppColors.rt,
              () async {
                try {
                  print('[DEBUG] User RT klik Approval Pengajuan, user: ' + user.toString());
                  final rtId = await getRtIdForUser(user);
                  print('[DEBUG] Hasil getRtIdForUser: ' + rtId.toString());
                  if (rtId == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data RT tidak ditemukan!')),
                    );
                    print('[DEBUG] RT ID tidak ditemukan!');
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PengajuanRTPage(rtId: rtId),
                    ),
                  );
                  print('[DEBUG] Navigasi ke PengajuanRTPage dengan rtId: ' + rtId.toString());
                } catch (e, stack) {
                  print('[DEBUG] Error Approval Pengajuan: ' + e.toString());
                  print('[DEBUG] Stacktrace: ' + stack.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Terjadi error: ' + e.toString())),
                  );
                }
              },
            ),
            _buildFeatureCard(
              context,
              'Laporan',
              Icons.assessment,
              AppColors.rt,
              () {
                // TODO: Navigate to reports page
              },
            ),
            _buildFeatureCard(
              context,
              'Pengaturan',
              Icons.settings,
              AppColors.rt,
              () {
                // TODO: Navigate to settings page
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRWFeatures(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fitur RW',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(
              context,
              'Data Warga',
              Icons.people,
              AppColors.rw,
              () {
                // TODO: Navigate to warga data page
              },
            ),
            _buildFeatureCard(
              context,
              'Monitoring RT',
              Icons.monitor,
              AppColors.rw,
              () {
                // TODO: Navigate to RT monitoring page
              },
            ),
            _buildFeatureCard(
              context,
              'Approval Level RW',
              Icons.approval,
              AppColors.rw,
              () {
                // TODO: Navigate to RW approval page
              },
            ),
            _buildFeatureCard(
              context,
              'Laporan',
              Icons.assessment,
              AppColors.rw,
              () {
                // TODO: Navigate to reports page
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case AppConfig.roleKepalaKeluarga:
        return AppColors.kepalaKeluarga;
      case AppConfig.roleRT:
        return AppColors.rt;
      case AppConfig.roleRW:
        return AppColors.rw;
      default:
        return AppColors.primary;
    }
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case AppConfig.roleKepalaKeluarga:
        return Icons.family_restroom;
      case AppConfig.roleRT:
        return Icons.home;
      case AppConfig.roleRW:
        return Icons.business;
      default:
        return Icons.person;
    }
  }

  String _getRoleDisplayName(String role) {
    switch (role) {
      case AppConfig.roleKepalaKeluarga:
        return 'Kepala Keluarga';
      case AppConfig.roleRT:
        return 'RT';
      case AppConfig.roleRW:
        return 'RW';
      default:
        return 'User';
    }
  }
} 