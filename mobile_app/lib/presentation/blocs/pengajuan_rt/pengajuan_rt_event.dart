import 'package:equatable/equatable.dart';

abstract class PengajuanRTEvent extends Equatable {
  const PengajuanRTEvent();
  @override
  List<Object?> get props => [];
}

class LoadPengajuanListByRT extends PengajuanRTEvent {
  final int rtId;
  const LoadPengajuanListByRT(this.rtId);
  @override
  List<Object?> get props => [rtId];
}

class ApprovePengajuanByRT extends PengajuanRTEvent {
  final String id;
  final String ttdRtUrl;
  const ApprovePengajuanByRT(this.id, this.ttdRtUrl);
  @override
  List<Object?> get props => [id, ttdRtUrl];
}

class RejectPengajuanByRT extends PengajuanRTEvent {
  final String id;
  const RejectPengajuanByRT(this.id);
  @override
  List<Object?> get props => [id];
}