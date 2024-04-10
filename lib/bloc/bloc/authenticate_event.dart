part of 'authenticate_bloc.dart';

sealed class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticateEvent {}

class LoggedIn extends AuthenticateEvent {
  final dynamic data;
  const LoggedIn({this.data});
  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LoggedIn { user: $data.toString() }';
}

class LoggedOut extends AuthenticateEvent {}

class GetProfile extends AuthenticateEvent {}

class SubmitProfile extends AuthenticateEvent {
  final String email;
  final String password;
  final String passwordbaru;
  const SubmitProfile(
      {required this.email,
      required this.password,
      required this.passwordbaru});
  @override
  List<Object> get props => [email, password, passwordbaru];

  @override
  String toString() => "Submmited on user";
}
