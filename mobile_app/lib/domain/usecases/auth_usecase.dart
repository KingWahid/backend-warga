import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/failures.dart';

class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}

class LogoutUseCase {
  final AuthRepository repository;
  
  LogoutUseCase(this.repository);
  
  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}

class GetCurrentUserUseCase {
  final AuthRepository repository;
  
  GetCurrentUserUseCase(this.repository);
  
  Future<Either<Failure, User?>> call() async {
    return await repository.getCurrentUser();
  }
}

class IsLoggedInUseCase {
  final AuthRepository repository;
  
  IsLoggedInUseCase(this.repository);
  
  Future<Either<Failure, bool>> call() async {
    return await repository.isLoggedIn();
  }
} 