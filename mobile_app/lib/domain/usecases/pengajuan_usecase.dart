import 'package:dartz/dartz.dart';
import '../entities/pengajuan.dart';
import '../repositories/pengajuan_repository.dart';
import '../../core/errors/failures.dart';

class GetPengajuanListUseCase {
  final PengajuanRepository repository;
  
  GetPengajuanListUseCase(this.repository);
  
  Future<Either<Failure, List<Pengajuan>>> call() async {
    return await repository.getPengajuanList();
  }
}

class GetPengajuanByIdUseCase {
  final PengajuanRepository repository;
  
  GetPengajuanByIdUseCase(this.repository);
  
  Future<Either<Failure, Pengajuan>> call(String id) async {
    return await repository.getPengajuanById(id);
  }
}

class CreatePengajuanUseCase {
  final PengajuanRepository repository;
  
  CreatePengajuanUseCase(this.repository);
  
  Future<Either<Failure, Pengajuan>> call(Pengajuan pengajuan) async {
    return await repository.createPengajuan(pengajuan);
  }
}

class UpdatePengajuanUseCase {
  final PengajuanRepository repository;
  
  UpdatePengajuanUseCase(this.repository);
  
  Future<Either<Failure, Pengajuan>> call(Pengajuan pengajuan) async {
    return await repository.updatePengajuan(pengajuan);
  }
}

class DeletePengajuanUseCase {
  final PengajuanRepository repository;
  
  DeletePengajuanUseCase(this.repository);
  
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deletePengajuan(id);
  }
} 