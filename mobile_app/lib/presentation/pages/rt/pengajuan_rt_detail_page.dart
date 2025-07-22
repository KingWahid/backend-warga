import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'dart:convert';
import 'package:mobile_warga/data/datasources/pengajuan_remote_data_source.dart';
import 'package:mobile_warga/data/models/pengajuan_model.dart';
import '../../../core/di/injection.dart';
import '../../../data/models/surat_model.dart';
import '../../../data/models/warga_model.dart';

class PengajuanRTDetailPage extends StatefulWidget {
  final String pengajuanId;
  const PengajuanRTDetailPage({Key? key, required this.pengajuanId}) : super(key: key);

  @override
  State<PengajuanRTDetailPage> createState() => _PengajuanRTDetailPageState();
}

class _PengajuanRTDetailPageState extends State<PengajuanRTDetailPage> {
  PengajuanModel? pengajuan;
  bool isLoading = true;
  late SignatureController _signatureController;

  @override
  void initState() {
    super.initState();
    fetchDetail();
    _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  Future<void> fetchDetail() async {
    try {
      final remote = getIt<PengajuanRemoteDataSource>();
      final result = await remote.getPengajuanById(widget.pengajuanId);
      setState(() {
        pengajuan = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil detail pengajuan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (pengajuan == null) return const Center(child: Text('Data tidak ditemukan'));

    final surat = pengajuan!.surat!;
    final warga = pengajuan!.warga!;
    final suratContent = generateSuratContent(surat, warga);

    return Scaffold(
      backgroundColor: Colors.grey[100], // atau AppColors.background
      appBar: AppBar(
        title: const Text('Preview Surat'),
        backgroundColor: Colors.blue, // atau AppColors.primary
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.withOpacity(0.1), // atau AppColors.primary.withOpacity(0.1)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jenis Surat: ${surat.nama}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Untuk: ${warga.namaLengkap}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Surat header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header surat
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PEMERINTAH KOTA JAKARTA',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    'KECAMATAN JAKARTA SELATAN',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    'KELURAHAN KEBANGUNAN',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'LOGO',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Judul surat
                        Text(
                          surat.nama.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Nomor surat
                        Text(
                          'Nomor: 470/001/RT.001/RW.001/${DateTime.now().year}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Isi surat
                        Text(
                          suratContent,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 30),
                        // Tanda tangan camat/lurah
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jakarta, ${_formatDate(DateTime.now())}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Lurah Kebangunan,',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 40),
                                Text(
                                  'Nama Lurah',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mengetahui:',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Camat Jakarta Selatan,',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 40),
                                Text(
                                  'Nama Camat',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Signature RT
                        Text('Tanda Tangan RT:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Signature(
                            controller: _signatureController,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => _signatureController.clear(),
                              child: const Text('Hapus Tanda Tangan'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_signatureController.isNotEmpty) {
                                    final signature = await _signatureController.toPngBytes();
                                    if (signature != null) {
                                      final base64Signature = base64Encode(signature);
                                      // Kirim base64Signature ke backend saat approve
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Silakan tanda tangani terlebih dahulu!')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Setujui'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  // TODO: Aksi tolak pengajuan
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Tolak'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String generateSuratContent(SuratModel surat, WargaModel warga) {
    String template = surat.template;
    template = template.replaceAll('{{NAMA_LENGKAP}}', warga.namaLengkap);
    template = template.replaceAll('{{NIK}}', warga.nik);
    template = template.replaceAll('{{NO_KK}}', warga.noKK);
    template = template.replaceAll('{{TEMPAT_LAHIR}}', warga.tempatLahir);
    template = template.replaceAll('{{TANGGAL_LAHIR}}', _formatDate(warga.tanggalLahir));
    template = template.replaceAll('{{JENIS_KELAMIN}}', warga.jenisKelamin);
    template = template.replaceAll('{{AGAMA}}', warga.agama);
    template = template.replaceAll('{{PENDIDIKAN}}', warga.pendidikan);
    template = template.replaceAll('{{JENIS_PEKERJAAN}}', warga.jenisPekerjaan);
    template = template.replaceAll('{{GOLONGAN_DARAH}}', warga.golonganDarah ?? '-');
    template = template.replaceAll('{{STATUS_PERKAWINAN}}', warga.statusPerkawinan);
    template = template.replaceAll('{{STATUS_KELUARGA}}', warga.statusKeluarga);
    template = template.replaceAll('{{KEWARGANEGARAAN}}', warga.kewarganegaraan);
    template = template.replaceAll('{{NAMA_AYAH}}', warga.namaAyah);
    template = template.replaceAll('{{NAMA_IBU}}', warga.namaIbu);
    template = template.replaceAll('{{TANGGAL_SURAT}}', _formatDate(DateTime.now()));
    return template;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
