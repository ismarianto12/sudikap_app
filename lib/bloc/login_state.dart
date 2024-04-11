part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginValidate extends LoginState {
  final bool formValid;
  LoginValidate({this.formValid = false}); // Tambahkan nilai default di sini
  @override
  List<Object> get porps => [formValid];
}

class LoginFailure extends LoginState {
  final String error;
  final bool formValid;
  const LoginFailure({required this.error, this.formValid = false});
  @override
  List<Object> get props => [error, formValid];
  @override
  String toString() => ' LoginFailure {error: $error, formValid: $formValid}';
}
