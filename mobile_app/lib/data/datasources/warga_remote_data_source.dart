import '../../core/network/api_client.dart';
import '../models/warga_model.dart';

abstract class WargaRemoteDataSource {
  Future<List<WargaModel>> getAnggotaKeluargaByUserID(String userID);
  Future<List<WargaModel>> getWargaByNoKK(String noKK);
  Future<WargaModel> getWargaByNIK(String nik);
  Future<WargaModel> getKepalaKeluargaByNoKK(String noKK);
  Future<List<WargaModel>> getAnggotaKeluargaByNoKK(String noKK);
  Future<List<WargaModel>> getAllWarga();
  Future<WargaModel> createWarga(Map<String, dynamic> data);
  Future<WargaModel> updateWarga(String id, Map<String, dynamic> data);
  Future<void> deleteWarga(String id);
}

class WargaRemoteDataSourceImpl implements WargaRemoteDataSource {
  final ApiClient apiClient;
  
  WargaRemoteDataSourceImpl(this.apiClient);
  
  @override
  Future<List<WargaModel>> getAnggotaKeluargaByUserID(String userID) async {
    try {
      print('Calling API: /warga/user/$userID/anggota-keluarga');
      final response = await apiClient.get('/warga/user/$userID/anggota-keluarga');
      
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'];
        print('Data: $data');
        final List<dynamic> anggotaKeluarga = data['anggota_keluarga'];
        print('Anggota keluarga count: ${anggotaKeluarga.length}');
        print('Anggota keluarga: $anggotaKeluarga');
        
        final List<WargaModel> result = anggotaKeluarga.map((json) => WargaModel.fromJson(json)).toList();
        print('Parsed result count: ${result.length}');
        return result;
      } else {
        throw Exception('Failed to get anggota keluarga: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('Error in getAnggotaKeluargaByUserID: $e');
      throw Exception('Failed to get anggota keluarga: $e');
    }
  }

  @override
  Future<List<WargaModel>> getWargaByNoKK(String noKK) async {
    try {
      final response = await apiClient.get('/warga/kk/$noKK');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'];
        final List<dynamic> wargas = data['wargas'];
        return wargas.map((json) => WargaModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get warga by No KK: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get warga by No KK: $e');
    }
  }

  @override
  Future<WargaModel> getWargaByNIK(String nik) async {
    try {
      final response = await apiClient.get('/warga/nik/$nik');
      
      if (response.statusCode == 200) {
        return WargaModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to get warga by NIK: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get warga by NIK: $e');
    }
  }

  @override
  Future<WargaModel> getKepalaKeluargaByNoKK(String noKK) async {
    try {
      final response = await apiClient.get('/warga/kepala-keluarga/$noKK');
      
      if (response.statusCode == 200) {
        return WargaModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to get kepala keluarga: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get kepala keluarga: $e');
    }
  }

  @override
  Future<List<WargaModel>> getAnggotaKeluargaByNoKK(String noKK) async {
    try {
      final response = await apiClient.get('/warga/anggota-keluarga/$noKK');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'];
        final List<dynamic> anggotaKeluarga = data['anggota_keluarga'];
        return anggotaKeluarga.map((json) => WargaModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get anggota keluarga: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get anggota keluarga: $e');
    }
  }

  @override
  Future<List<WargaModel>> getAllWarga() async {
    try {
      final response = await apiClient.get('/warga');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['data'];
        final List<dynamic> wargas = data['wargas'];
        return wargas.map((json) => WargaModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get all warga: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get all warga: $e');
    }
  }

  @override
  Future<WargaModel> createWarga(Map<String, dynamic> data) async {
    try {
      final response = await apiClient.post('/warga', data: data);
      
      if (response.statusCode == 201) {
        return WargaModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to create warga: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to create warga: $e');
    }
  }

  @override
  Future<WargaModel> updateWarga(String id, Map<String, dynamic> data) async {
    try {
      final response = await apiClient.put('/warga/$id', data: data);
      
      if (response.statusCode == 200) {
        return WargaModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to update warga: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to update warga: $e');
    }
  }

  @override
  Future<void> deleteWarga(String id) async {
    try {
      final response = await apiClient.delete('/warga/$id');
      
      if (response.statusCode != 200) {
        throw Exception('Failed to delete warga: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to delete warga: $e');
    }
  }
} 