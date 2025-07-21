import 'package:equatable/equatable.dart';
import '../../../domain/entities/pengajuan.dart';

abstract class PengajuanRTState extends Equatable {
  const PengajuanRTState();
  @override
  List<Object?> get props => [];
}

class PengajuanRTInitial extends PengajuanRTState {}

class PengajuanRTLoading extends PengajuanRTState {}

class PengajuanRTLoaded extends PengajuanRTState {
  final List<Pengajuan> pengajuanList;
  const PengajuanRTLoaded(this.pengajuanList);
  @override
  List<Object?> get props => [pengajuanList];
}

class PengajuanRTSuccess extends PengajuanRTState {
  final String message;
  const PengajuanRTSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class PengajuanRTError extends PengajuanRTState {
  final String message;
  const PengajuanRTError(this.message);
  @override
  List<Object?> get props => [message];
}
