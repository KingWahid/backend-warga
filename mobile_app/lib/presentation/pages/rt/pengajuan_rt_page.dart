import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/pengajuan.dart';
import '../../blocs/pengajuan_rt/pengajuan_rt_bloc.dart';
import '../../blocs/pengajuan_rt/pengajuan_rt_event.dart';
import '../../blocs/pengajuan_rt/pengajuan_rt_state.dart';
import '../../../core/di/injection.dart';

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
              print('[DEBUG] Data pengajuan: ${state.pengajuanList.map((e) => e.toJson()).toList()}');
              return ListView.builder(
                itemCount: state.pengajuanList.length,
                itemBuilder: (context, index) {
                  final pengajuan = state.pengajuanList[index];
                  print('[DEBUG] wargaNama: ${pengajuan.wargaNama}, suratNama: ${pengajuan.suratNama}');
                  return ListTile(
                    title: Text(pengajuan.suratNama), // Jenis surat
                    subtitle: Text('Pengaju: ${pengajuan.wargaNama}'), // Nama pengaju
                    trailing: Text(pengajuan.status),
                    onTap: () {
                      // Tampilkan detail, approval, dsb
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PengajuanRTDetailPage(pengajuan: pengajuan),
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
              // Reload list setelah approve/reject
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

class PengajuanRTDetailPage extends StatefulWidget {
  final Pengajuan pengajuan;
  const PengajuanRTDetailPage({required this.pengajuan, Key? key}) : super(key: key);

  @override
  State<PengajuanRTDetailPage> createState() => _PengajuanRTDetailPageState();
}

class _PengajuanRTDetailPageState extends State<PengajuanRTDetailPage> {
  String? ttdUrl; // Simulasi upload/generate ttd digital

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PengajuanRTBloc>();
    return Scaffold(
      appBar: AppBar(title: Text('Detail Pengajuan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jenis Surat: ${widget.pengajuan.suratNama}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Nama Pemohon: ${widget.pengajuan.wargaNama}'),
            const SizedBox(height: 8),
            Text('Status: ${widget.pengajuan.status}'),
            const SizedBox(height: 16),
            // Simulasi upload/generate ttd digital
            TextField(
              decoration: const InputDecoration(labelText: 'URL Tanda Tangan Digital RT'),
              onChanged: (val) => ttdUrl = val,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (ttdUrl == null || ttdUrl!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Isi URL tanda tangan digital!')));
                      return;
                    }
                    bloc.add(ApprovePengajuanByRT(widget.pengajuan.id, ttdUrl!));
                    Navigator.pop(context);
                  },
                  child: const Text('Tanda Tangani & Approve'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {
                    bloc.add(RejectPengajuanByRT(widget.pengajuan.id));
                    Navigator.pop(context);
                  },
                  child: const Text('Tolak'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
