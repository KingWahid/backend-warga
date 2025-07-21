import 'package:dartz/dartz.dart';
import '../../domain/entities/pengajuan.dart';
import '../../domain/repositories/pengajuan_repository.dart';
import '../../core/errors/failures.dart';
import '../datasources/pengajuan_remote_data_source.dart';
import '../models/pengajuan_model.dart';

class PengajuanRepositoryImpl implements PengajuanRepository {
  final PengajuanRemoteDataSource remoteDataSource;
  
  PengajuanRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<Either<Failure, List<Pengajuan>>> getPengajuanList() async {
    try {
      final pengajuanList = await remoteDataSource.getPengajuanList();
      return Right(pengajuanList);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Pengajuan>> getPengajuanById(String id) async {
    try {
      final pengajuan = await remoteDataSource.getPengajuanById(id);
      return Right(pengajuan);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Pengajuan>> createPengajuan(Pengajuan pengajuan) async {
    try {
      final pengajuanModel = PengajuanModel.fromEntity(pengajuan);
      final createdPengajuan = await remoteDataSource.createPengajuan(pengajuanModel.toJsonCreate());
      return Right(createdPengajuan);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Pengajuan>> updatePengajuan(Pengajuan pengajuan) async {
    try {
      final pengajuanModel = PengajuanModel.fromEntity(pengajuan);
      final updatedPengajuan = await remoteDataSource.updatePengajuan(pengajuanModel);
      return Right(updatedPengajuan);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> deletePengajuan(String id) async {
    try {
      await remoteDataSource.deletePengajuan(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Pengajuan>>> getPengajuanListByRT(int rtId) async {
    try {
      final pengajuanList = await remoteDataSource.getPengajuanListByRT(rtId);
      return Right(pengajuanList);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> approvePengajuanByRT(String id, String ttdRtUrl) async {
    try {
      await remoteDataSource.approvePengajuanByRT(id, ttdRtUrl);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rejectPengajuanByRT(String id) async {
    try {
      await remoteDataSource.rejectPengajuanByRT(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
} 