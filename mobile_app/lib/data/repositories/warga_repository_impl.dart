import 'package:dartz/dartz.dart';
import '../../domain/entities/warga.dart';
import '../../domain/repositories/warga_repository.dart';
import '../../core/errors/failures.dart';
import '../datasources/warga_remote_data_source.dart';

class WargaRepositoryImpl implements WargaRepository {
  final WargaRemoteDataSource remoteDataSource;
  
  WargaRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<Either<Failure, List<Warga>>> getAnggotaKeluargaByUserID(String userID) async {
    try {
      final wargaList = await remoteDataSource.getAnggotaKeluargaByUserID(userID);
      return Right(wargaList);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Warga>>> getWargaByNoKK(String noKK) async {
    try {
      final wargaList = await remoteDataSource.getWargaByNoKK(noKK);
      return Right(wargaList);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Warga>> getWargaByNIK(String nik) async {
    try {
      final warga = await remoteDataSource.getWargaByNIK(nik);
      return Right(warga);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Warga>> getKepalaKeluargaByNoKK(String noKK) async {
    try {
      final warga = await remoteDataSource.getKepalaKeluargaByNoKK(noKK);
      return Right(warga);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Warga>>> getAnggotaKeluargaByNoKK(String noKK) async {
    try {
      final wargaList = await remoteDataSource.getAnggotaKeluargaByNoKK(noKK);
      return Right(wargaList);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Warga>>> getAllWarga() async {
    try {
      final wargaList = await remoteDataSource.getAllWarga();
      return Right(wargaList);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Warga>> createWarga(Map<String, dynamic> data) async {
    try {
      final warga = await remoteDataSource.createWarga(data);
      return Right(warga);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Warga>> updateWarga(String id, Map<String, dynamic> data) async {
    try {
      final warga = await remoteDataSource.updateWarga(id, data);
      return Right(warga);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWarga(String id) async {
    try {
      await remoteDataSource.deleteWarga(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
} 