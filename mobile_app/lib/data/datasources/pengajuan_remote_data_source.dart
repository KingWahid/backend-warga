import '../../core/network/api_client.dart';
import '../models/pengajuan_model.dart';

abstract class PengajuanRemoteDataSource {
  Future<List<PengajuanModel>> getPengajuanList();
  Future<PengajuanModel> getPengajuanById(String id);
  Future<PengajuanModel> createPengajuan(PengajuanModel pengajuan);
  Future<PengajuanModel> updatePengajuan(PengajuanModel pengajuan);
  Future<void> deletePengajuan(String id);
}

class PengajuanRemoteDataSourceImpl implements PengajuanRemoteDataSource {
  final ApiClient apiClient;
  
  PengajuanRemoteDataSourceImpl(this.apiClient);
  
  @override
  Future<List<PengajuanModel>> getPengajuanList() async {
    try {
      final response = await apiClient.get('/pengajuan');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PengajuanModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get pengajuan list: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get pengajuan list: $e');
    }
  }
  
  @override
  Future<PengajuanModel> getPengajuanById(String id) async {
    try {
      final response = await apiClient.get('/pengajuan/$id');
      
      if (response.statusCode == 200) {
        return PengajuanModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get pengajuan: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get pengajuan: $e');
    }
  }
  
  @override
  Future<PengajuanModel> createPengajuan(PengajuanModel pengajuan) async {
    try {
      final response = await apiClient.post('/pengajuan', data: pengajuan.toJson());
      
      if (response.statusCode == 201) {
        return PengajuanModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create pengajuan: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to create pengajuan: $e');
    }
  }
  
  @override
  Future<PengajuanModel> updatePengajuan(PengajuanModel pengajuan) async {
    try {
      final response = await apiClient.put('/pengajuan/${pengajuan.id}', data: pengajuan.toJson());
      
      if (response.statusCode == 200) {
        return PengajuanModel.fromJson(response.data);
      } else {
        throw Exception('Failed to update pengajuan: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to update pengajuan: $e');
    }
  }
  
  @override
  Future<void> deletePengajuan(String id) async {
    try {
      final response = await apiClient.delete('/pengajuan/$id');
      
      if (response.statusCode != 200) {
        throw Exception('Failed to delete pengajuan: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to delete pengajuan: $e');
    }
  }
} 