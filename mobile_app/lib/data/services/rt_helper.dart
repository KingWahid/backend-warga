import '../../domain/entities/user.dart';
import '../datasources/warga_remote_data_source.dart';
import '../datasources/kartu_keluarga_remote_data_source.dart';
import '../../core/di/injection.dart';

Future<int> getRtIdForUser(User user) async {
  if (user.wargaId == null) return 0;

  final wargaRemoteDataSource = getIt<WargaRemoteDataSource>();
  final warga = await wargaRemoteDataSource.getWargaById(user.wargaId!);
  if (warga == null) return 0;

  final kkRemoteDataSource = getIt<KartuKeluargaRemoteDataSource>();
  final kk = await kkRemoteDataSource.getKartuKeluargaByNoKK(warga.noKK);
  if (kk == null) return 0;

  return kk.rtId;
}
