import 'package:dartz/dartz.dart';
import '../../domain/entities/surat.dart';
import '../../domain/repositories/surat_repository.dart';
import '../../core/errors/failures.dart';
import '../datasources/surat_remote_data_source.dart';

class SuratRepositoryImpl implements SuratRepository {
  final SuratRemoteDataSource remoteDataSource;
  
  SuratRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<Either<Failure, List<Surat>>> getSuratList() async {
    try {
      final suratList = await remoteDataSource.getSuratList();
      return Right(suratList);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Surat>> getSuratById(String id) async {
    try {
      final surat = await remoteDataSource.getSuratById(id);
      return Right(surat);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
} 