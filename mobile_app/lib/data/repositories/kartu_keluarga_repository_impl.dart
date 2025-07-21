import '../../domain/repositories/kartu_keluarga_repository.dart';
import '../models/kartu_keluarga_model.dart';
import '../datasources/kartu_keluarga_remote_data_source.dart';

class KartuKeluargaRepositoryImpl implements KartuKeluargaRepository {
  final KartuKeluargaRemoteDataSource remoteDataSource;

  KartuKeluargaRepositoryImpl(this.remoteDataSource);

  @override
  Future<KartuKeluargaModel?> getKartuKeluargaByNoKK(String noKK) {
    return remoteDataSource.getKartuKeluargaByNoKK(noKK);
  }
}
