import 'package:dartz/dartz.dart';
import '../entities/surat.dart';
import '../../core/errors/failures.dart';

abstract class SuratRepository {
  Future<Either<Failure, List<Surat>>> getSuratList();
  Future<Either<Failure, Surat>> getSuratById(String id);
} 