import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/pengajuan_usecase.dart';
import 'pengajuan_rt_event.dart';
import 'pengajuan_rt_state.dart';

class PengajuanRTBloc extends Bloc<PengajuanRTEvent, PengajuanRTState> {
  final GetPengajuanListByRTUseCase getPengajuanListByRTUseCase;
  final ApprovePengajuanByRTUseCase approvePengajuanByRTUseCase;
  final RejectPengajuanByRTUseCase rejectPengajuanByRTUseCase;

  PengajuanRTBloc({
    required this.getPengajuanListByRTUseCase,
    required this.approvePengajuanByRTUseCase,
    required this.rejectPengajuanByRTUseCase,
  }) : super(PengajuanRTInitial()) {
    on<LoadPengajuanListByRT>(_onLoadPengajuanListByRT);
    on<ApprovePengajuanByRT>(_onApprovePengajuanByRT);
    on<RejectPengajuanByRT>(_onRejectPengajuanByRT);
  }

  Future<void> _onLoadPengajuanListByRT(
      LoadPengajuanListByRT event, Emitter<PengajuanRTState> emit) async {
    emit(PengajuanRTLoading());
    final result = await getPengajuanListByRTUseCase(event.rtId);
    result.fold(
      (failure) => emit(PengajuanRTError(failure.toString())),
      (list) => emit(PengajuanRTLoaded(list)),
    );
  }

  Future<void> _onApprovePengajuanByRT(
      ApprovePengajuanByRT event, Emitter<PengajuanRTState> emit) async {
    emit(PengajuanRTLoading());
    final result = await approvePengajuanByRTUseCase(event.id, event.ttdRtUrl);
    result.fold(
      (failure) => emit(PengajuanRTError(failure.toString())),
      (_) => emit(PengajuanRTSuccess('Pengajuan berhasil disetujui & ditandatangani')),
    );
  }

  Future<void> _onRejectPengajuanByRT(
      RejectPengajuanByRT event, Emitter<PengajuanRTState> emit) async {
    emit(PengajuanRTLoading());
    final result = await rejectPengajuanByRTUseCase(event.id);
    result.fold(
      (failure) => emit(PengajuanRTError(failure.toString())),
      (_) => emit(PengajuanRTSuccess('Pengajuan berhasil ditolak')),
    );
  }
}
