import '../models/kartu_keluarga_model.dart';
import '../../core/network/api_client.dart';

abstract class KartuKeluargaRemoteDataSource {
  Future<KartuKeluargaModel?> getKartuKeluargaByNoKK(String noKK);
}

class KartuKeluargaRemoteDataSourceImpl implements KartuKeluargaRemoteDataSource {
  final ApiClient apiClient;

  KartuKeluargaRemoteDataSourceImpl(this.apiClient);

  @override
  Future<KartuKeluargaModel?> getKartuKeluargaByNoKK(String noKK) async {
    final response = await apiClient.get('/kartu-keluarga/no-kk/$noKK');
    if (response.statusCode == 200) {
      return KartuKeluargaModel.fromJson(response.data['data']);
    }
    return null;
  }
}
