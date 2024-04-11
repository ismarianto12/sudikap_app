part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginCheckValid extends LoginEvent {
  final String username;
  final String password;

  const LoginCheckValid({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;

  const LoginSubmitted({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
