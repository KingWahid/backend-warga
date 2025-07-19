import 'package:equatable/equatable.dart';
import '../../../domain/entities/warga.dart';

abstract class WargaState extends Equatable {
  const WargaState();
  
  @override
  List<Object> get props => [];
}

class WargaInitial extends WargaState {}

class WargaLoading extends WargaState {}

class WargaLoaded extends WargaState {
  final List<Warga> anggotaKeluarga;
  
  const WargaLoaded(this.anggotaKeluarga);
  
  @override
  List<Object> get props => [anggotaKeluarga];
}

class WargaError extends WargaState {
  final String message;
  
  const WargaError(this.message);
  
  @override
  List<Object> get props => [message];
} 