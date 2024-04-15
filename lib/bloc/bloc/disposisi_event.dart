part of 'disposisi_bloc.dart';

sealed class DisposisiEvent extends Equatable {
  const DisposisiEvent();
}

class DisposisiGetted extends DisposisiEvent {
  final int idsurat;
  const DisposisiGetted(reposurat, {required this.idsurat});
  @override
  List<Object> get props => [];
}

abstract class DisposisiSave extends DisposisiEvent {
  final dynamic data;
  @override
  const DisposisiSave(this.data);
}
