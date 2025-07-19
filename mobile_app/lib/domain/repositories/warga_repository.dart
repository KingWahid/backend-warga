import 'package:dartz/dartz.dart';
import '../entities/warga.dart';
import '../../core/errors/failures.dart';

abstract class WargaRepository {
  Future<Either<Failure, List<Warga>>> getAnggotaKeluargaByUserID(String userID);
  Future<Either<Failure, List<Warga>>> getWargaByNoKK(String noKK);
  Future<Either<Failure, Warga>> getWargaByNIK(String nik);
  Future<Either<Failure, Warga>> getKepalaKeluargaByNoKK(String noKK);
  Future<Either<Failure, List<Warga>>> getAnggotaKeluargaByNoKK(String noKK);
  Future<Either<Failure, List<Warga>>> getAllWarga();
  Future<Either<Failure, Warga>> createWarga(Map<String, dynamic> data);
  Future<Either<Failure, Warga>> updateWarga(String id, Map<String, dynamic> data);
  Future<Either<Failure, void>> deleteWarga(String id);
} 