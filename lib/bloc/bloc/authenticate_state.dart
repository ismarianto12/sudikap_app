part of 'authenticate_bloc.dart';

sealed class AuthenticateState extends Equatable {
  const AuthenticateState();

  @override
  List<Object> get props => [];
}

class AuthenticateInitial extends AuthenticateState {}

class AuthenticateAuthenticated extends AuthenticateState {}

class AuthenticateunAuthenticated extends AuthenticateState {}

class AuthenticateisLoading extends AuthenticateState {}

// creat action exampel to changfe password
class ProfileLoading extends AuthenticateState {}
class ProfileLoaded extends AuthenticateState {
  final List<dynamic> profiledata;
  ProfileLoaded(this.profiledata);
  @override
  List<Object> get props => [profiledata];
}


class ProfileSubmited extends AuthenticateState {}

class ProfileError extends AuthenticateState {
  final String error;

  const ProfileError({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => "to String data";
}
