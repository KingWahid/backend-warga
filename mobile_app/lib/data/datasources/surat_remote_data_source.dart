import '../../core/network/api_client.dart';
import '../models/surat_model.dart';

abstract class SuratRemoteDataSource {
  Future<List<SuratModel>> getSuratList();
  Future<SuratModel> getSuratById(String id);
}

class SuratRemoteDataSourceImpl implements SuratRemoteDataSource {
  final ApiClient apiClient;
  
  SuratRemoteDataSourceImpl(this.apiClient);
  
  @override
  Future<List<SuratModel>> getSuratList() async {
    try {
      final response = await apiClient.get('/surat');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => SuratModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get surat list: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get surat list: $e');
    }
  }
  
  @override
  Future<SuratModel> getSuratById(String id) async {
    try {
      final response = await apiClient.get('/surat/$id');
      
      if (response.statusCode == 200) {
        return SuratModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get surat: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Failed to get surat: $e');
    }
  }
} 