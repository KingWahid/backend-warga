import 'package:dartz/dartz.dart';
import '../entities/warga.dart';
import '../repositories/warga_repository.dart';
import '../../core/errors/failures.dart';

class GetWargaByNoKKUseCase {
  final WargaRepository repository;
  
  GetWargaByNoKKUseCase(this.repository);
  
  Future<Either<Failure, List<Warga>>> call(String noKK) async {
    return await repository.getWargaByNoKK(noKK);
  }
}

class GetWargaByNIKUseCase {
  final WargaRepository repository;
  
  GetWargaByNIKUseCase(this.repository);
  
  Future<Either<Failure, Warga>> call(String nik) async {
    return await repository.getWargaByNIK(nik);
  }
}

class GetKepalaKeluargaByNoKKUseCase {
  final WargaRepository repository;
  
  GetKepalaKeluargaByNoKKUseCase(this.repository);
  
  Future<Either<Failure, Warga>> call(String noKK) async {
    return await repository.getKepalaKeluargaByNoKK(noKK);
  }
}

class GetAnggotaKeluargaByNoKKUseCase {
  final WargaRepository repository;
  
  GetAnggotaKeluargaByNoKKUseCase(this.repository);
  
  Future<Either<Failure, List<Warga>>> call(String noKK) async {
    return await repository.getAnggotaKeluargaByNoKK(noKK);
  }
}

class GetAllWargaUseCase {
  final WargaRepository repository;
  
  GetAllWargaUseCase(this.repository);
  
  Future<Either<Failure, List<Warga>>> call() async {
    return await repository.getAllWarga();
  }
}

class CreateWargaUseCase {
  final WargaRepository repository;
  
  CreateWargaUseCase(this.repository);
  
  Future<Either<Failure, Warga>> call(Map<String, dynamic> data) async {
    return await repository.createWarga(data);
  }
}

class UpdateWargaUseCase {
  final WargaRepository repository;
  
  UpdateWargaUseCase(this.repository);
  
  Future<Either<Failure, Warga>> call(String id, Map<String, dynamic> data) async {
    return await repository.updateWarga(id, data);
  }
}

class DeleteWargaUseCase {
  final WargaRepository repository;
  
  DeleteWargaUseCase(this.repository);
  
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteWarga(id);
  }
} 

class GetAnggotaKeluargaByUserIDUseCase {
  final WargaRepository repository;
  
  GetAnggotaKeluargaByUserIDUseCase(this.repository);
  
  Future<Either<Failure, List<Warga>>> call(String userID) async {
    return await repository.getAnggotaKeluargaByUserID(userID);
  }
} 