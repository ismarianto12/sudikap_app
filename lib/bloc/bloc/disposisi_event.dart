part of 'disposisi_bloc.dart';

sealed class DisposisiEvent extends Equatable {
  const DisposisiEvent();
}

class DisposisiGetted extends DisposisiEvent {
  final int idsurat;

  const DisposisiGetted({required this.idsurat});

  @override
  List<Object> get props => [];
}
