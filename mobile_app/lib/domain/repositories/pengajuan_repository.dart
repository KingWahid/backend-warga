import 'package:dartz/dartz.dart';
import '../entities/pengajuan.dart';
import '../../core/errors/failures.dart';

abstract class PengajuanRepository {
  Future<Either<Failure, List<Pengajuan>>> getPengajuanList();
  Future<Either<Failure, Pengajuan>> getPengajuanById(String id);
  Future<Either<Failure, Pengajuan>> createPengajuan(Pengajuan pengajuan);
  Future<Either<Failure, Pengajuan>> updatePengajuan(Pengajuan pengajuan);
  Future<Either<Failure, void>> deletePengajuan(String id);
  Future<Either<Failure, List<Pengajuan>>> getPengajuanListByRT(int rtId);
  Future<Either<Failure, void>> approvePengajuanByRT(String id, String ttdRtUrl);
  Future<Either<Failure, void>> rejectPengajuanByRT(String id);
} 