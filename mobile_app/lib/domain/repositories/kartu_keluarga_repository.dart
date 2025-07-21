import '../../data/models/kartu_keluarga_model.dart';

abstract class KartuKeluargaRepository {
  Future<KartuKeluargaModel?> getKartuKeluargaByNoKK(String noKK);
}
