import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/kartu_keluarga_usecase.dart';
import '../../../data/models/kartu_keluarga_model.dart';

// Event
abstract class KartuKeluargaEvent {}
class FetchKartuKeluargaByNoKK extends KartuKeluargaEvent {
  final String noKK;
  FetchKartuKeluargaByNoKK(this.noKK);
}

// State
abstract class KartuKeluargaState {}
class KartuKeluargaInitial extends KartuKeluargaState {}
class KartuKeluargaLoading extends KartuKeluargaState {}
class KartuKeluargaLoaded extends KartuKeluargaState {
  final KartuKeluargaModel kk;
  KartuKeluargaLoaded(this.kk);
}
class KartuKeluargaError extends KartuKeluargaState {
  final String message;
  KartuKeluargaError(this.message);
}

// Bloc
class KartuKeluargaBloc extends Bloc<KartuKeluargaEvent, KartuKeluargaState> {
  final GetKartuKeluargaByNoKKUseCase getKartuKeluargaByNoKKUseCase;

  KartuKeluargaBloc({required this.getKartuKeluargaByNoKKUseCase}) : super(KartuKeluargaInitial()) {
    on<FetchKartuKeluargaByNoKK>((event, emit) async {
      emit(KartuKeluargaLoading());
      try {
        final kk = await getKartuKeluargaByNoKKUseCase(event.noKK);
        if (kk != null) {
          emit(KartuKeluargaLoaded(kk));
        } else {
          emit(KartuKeluargaError('Data tidak ditemukan'));
        }
      } catch (e) {
        emit(KartuKeluargaError(e.toString()));
      }
    });
  }
}
