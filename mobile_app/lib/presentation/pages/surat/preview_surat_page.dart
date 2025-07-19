import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/surat.dart';
import '../../../domain/entities/warga.dart';

class PreviewSuratPage extends StatefulWidget {
  final Map<String, dynamic> data;
  
  const PreviewSuratPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<PreviewSuratPage> createState() => _PreviewSuratPageState();
}

class _PreviewSuratPageState extends State<PreviewSuratPage> {
  late Surat surat;
  late Warga warga;
  String suratContent = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    surat = widget.data['surat'] as Surat;
    warga = widget.data['warga'] as Warga;
    _generateSuratContent();
  }

  void _generateSuratContent() {
    // Generate surat content based on template and warga data
    String template = surat.template;
    
    // Replace template variables with actual data
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
    
    // Add current date
    template = template.replaceAll('{{TANGGAL_SURAT}}', _formatDate(DateTime.now()));
    
    setState(() {
      suratContent = template;
      isLoading = false;
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Preview Surat'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printSurat,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareSurat,
          ),
        ],
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
                  'Jenis Surat: ${surat.nama}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Untuk: ${warga.namaLengkap}',
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
            child: _buildContent(),
          ),
          
          // Action buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Kembali'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitPengajuan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Ajukan Surat'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
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
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            'KECAMATAN JAKARTA SELATAN',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            'KELURAHAN KEBANGUNAN',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'LOGO',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
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
                
                // Tanda tangan
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _printSurat() {
    // TODO: Implement print functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur print akan segera tersedia'),
      ),
    );
  }

  void _shareSurat() {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur share akan segera tersedia'),
      ),
    );
  }

  void _submitPengajuan() {
    // TODO: Implement submit pengajuan
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin mengajukan surat ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _submitPengajuanToServer();
            },
            child: const Text('Ajukan'),
          ),
        ],
      ),
    );
  }

  void _submitPengajuanToServer() {
    // TODO: Implement API call to submit pengajuan
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengajuan surat berhasil dikirim'),
        backgroundColor: Colors.green,
      ),
    );
    
    // Navigate back to dashboard
    context.go('/');
  }
} 