import 'package:dartz/dartz.dart';
import '../entities/surat.dart';
import '../repositories/surat_repository.dart';
import '../../core/errors/failures.dart';

class GetSuratListUseCase {
  final SuratRepository repository;
  
  GetSuratListUseCase(this.repository);
  
  Future<Either<Failure, List<Surat>>> call() async {
    return await repository.getSuratList();
  }
}

class GetSuratByIdUseCase {
  final SuratRepository repository;
  
  GetSuratByIdUseCase(this.repository);
  
  Future<Either<Failure, Surat>> call(String id) async {
    return await repository.getSuratById(id);
  }
} 