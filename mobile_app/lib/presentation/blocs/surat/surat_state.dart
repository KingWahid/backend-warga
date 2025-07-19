import 'package:equatable/equatable.dart';
import '../../../domain/entities/surat.dart';

abstract class SuratState extends Equatable {
  const SuratState();
  
  @override
  List<Object> get props => [];
}

class SuratInitial extends SuratState {}

class SuratLoading extends SuratState {}

class SuratLoaded extends SuratState {
  final List<Surat> suratList;
  
  const SuratLoaded(this.suratList);
  
  @override
  List<Object> get props => [suratList];
}

class SuratError extends SuratState {
  final String message;
  
  const SuratError(this.message);
  
  @override
  List<Object> get props => [message];
} 