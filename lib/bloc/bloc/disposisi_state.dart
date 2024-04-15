part of 'disposisi_bloc.dart';

sealed class DisposisiState extends Equatable {
  const DisposisiState();
  @override
  List<Object> get props => [];
}

class DisposisiInitial extends DisposisiState {}

class DisposisiIsloaded extends DisposisiState {}

class DisposisiFilure extends DisposisiState {
  final String error;
  const DisposisiFilure({required this.error});
  @override
  List<Object> get porps => [error];

  @override
  String toString() => 'disposisi surat failure';
}

class Dispisissaveinitial extends DisposisiState {}

class DispisissaveIsloaded extends DisposisiState {}

class DispisissaveFailure extends DisposisiState {
  final String error;
  const DispisissaveFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => "${error}";
}
