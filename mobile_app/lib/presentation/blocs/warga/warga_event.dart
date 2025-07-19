import 'package:equatable/equatable.dart';

abstract class WargaEvent extends Equatable {
  const WargaEvent();

  @override
  List<Object> get props => [];
}

class LoadAnggotaKeluarga extends WargaEvent {
  final String userID;
  
  const LoadAnggotaKeluarga(this.userID);
  
  @override
  List<Object> get props => [userID];
} 