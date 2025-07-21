import '../../data/models/kartu_keluarga_model.dart';
import '../repositories/kartu_keluarga_repository.dart';

class GetKartuKeluargaByNoKKUseCase {
  final KartuKeluargaRepository repository;

  GetKartuKeluargaByNoKKUseCase(this.repository);

  Future<KartuKeluargaModel?> call(String noKK) {
    return repository.getKartuKeluargaByNoKK(noKK);
  }
}
