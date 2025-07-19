import 'package:equatable/equatable.dart';

abstract class SuratEvent extends Equatable {
  const SuratEvent();

  @override
  List<Object> get props => [];
}

class LoadSuratList extends SuratEvent {}

class LoadSuratById extends SuratEvent {
  final String id;
  
  const LoadSuratById(this.id);
  
  @override
  List<Object> get props => [id];
} 