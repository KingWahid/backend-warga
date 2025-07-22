import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../blocs/pengajuan_rt/pengajuan_rt_bloc.dart';
import '../../blocs/pengajuan_rt/pengajuan_rt_event.dart';
import '../../blocs/pengajuan_rt/pengajuan_rt_state.dart';
import 'package:mobile_warga/data/models/pengajuan_model.dart';
import 'pengajuan_rt_detail_page.dart'; // pastikan import ini benar
import '../../../data/models/surat_model.dart';
import '../../../data/models/warga_model.dart';

class PengajuanRTPage extends StatelessWidget {
  final int rtId;
  const PengajuanRTPage({required this.rtId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PengajuanRTBloc>()..add(LoadPengajuanListByRT(rtId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pengajuan Masuk RT')),
        body: BlocBuilder<PengajuanRTBloc, PengajuanRTState>(
          builder: (context, state) {
            if (state is PengajuanRTLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PengajuanRTLoaded) {
              if (state.pengajuanList.isEmpty) {
                return const Center(child: Text('Belum ada pengajuan masuk'));
              }
              return ListView.builder(
                itemCount: state.pengajuanList.length,
                itemBuilder: (context, index) {
                  final pengajuan = state.pengajuanList[index] as PengajuanModel;
                  return ListTile(
                    title: Text(pengajuan.wargaNama ?? '-'),
                    subtitle: Text(pengajuan.suratNama ?? '-'),
                    trailing: Text(pengajuan.status),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PengajuanRTDetailPage(pengajuanId: pengajuan.id),
                        ),
                      );
                    },
                  );
                },
              );
            }
            if (state is PengajuanRTError) {
              return Center(child: Text(state.message));
            }
            if (state is PengajuanRTSuccess) {
              context.read<PengajuanRTBloc>().add(LoadPengajuanListByRT(rtId));
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
