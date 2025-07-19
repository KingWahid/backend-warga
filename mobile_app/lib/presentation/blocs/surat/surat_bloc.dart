import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/surat_usecase.dart';
import '../../../core/errors/failures.dart';
import 'surat_event.dart';
import 'surat_state.dart';

class SuratBloc extends Bloc<SuratEvent, SuratState> {
  final GetSuratListUseCase getSuratListUseCase;
  final GetSuratByIdUseCase getSuratByIdUseCase;

  SuratBloc({
    required this.getSuratListUseCase,
    required this.getSuratByIdUseCase,
  }) : super(SuratInitial()) {
    on<LoadSuratList>(_onLoadSuratList);
    on<LoadSuratById>(_onLoadSuratById);
  }

  Future<void> _onLoadSuratList(LoadSuratList event, Emitter<SuratState> emit) async {
    emit(SuratLoading());
    
    final result = await getSuratListUseCase();
    
    result.fold(
      (failure) => emit(SuratError(_mapFailureToMessage(failure))),
      (suratList) => emit(SuratLoaded(suratList)),
    );
  }

  Future<void> _onLoadSuratById(LoadSuratById event, Emitter<SuratState> emit) async {
    emit(SuratLoading());
    
    final result = await getSuratByIdUseCase(event.id);
    
    result.fold(
      (failure) => emit(SuratError(_mapFailureToMessage(failure))),
      (surat) => emit(SuratLoaded([surat])),
    );
  }
  
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Terjadi kesalahan pada server';
      case NetworkFailure:
        return 'Tidak dapat terhubung ke server';
      default:
        return 'Terjadi kesalahan yang tidak diketahui';
    }
  }
} 