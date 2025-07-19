import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/warga_usecase.dart';
import '../../../core/errors/failures.dart';
import 'warga_event.dart';
import 'warga_state.dart';

class WargaBloc extends Bloc<WargaEvent, WargaState> {
  final GetAnggotaKeluargaByUserIDUseCase getAnggotaKeluargaByUserIDUseCase;
  
  WargaBloc({
    required this.getAnggotaKeluargaByUserIDUseCase,
  }) : super(WargaInitial()) {
    on<LoadAnggotaKeluarga>(_onLoadAnggotaKeluarga);
  }
  
  Future<void> _onLoadAnggotaKeluarga(LoadAnggotaKeluarga event, Emitter<WargaState> emit) async {
    print('WargaBloc: Loading anggota keluarga for userID: ${event.userID}');
    emit(WargaLoading());
    
    final result = await getAnggotaKeluargaByUserIDUseCase(event.userID);
    
    result.fold(
      (failure) {
        print('WargaBloc: Error - ${failure.toString()}');
        emit(WargaError(_mapFailureToMessage(failure)));
      },
      (anggotaKeluarga) {
        print('WargaBloc: Success - Found ${anggotaKeluarga.length} anggota keluarga');
        emit(WargaLoaded(anggotaKeluarga));
      },
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