import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sistem_kearsipan/repository/loginRepo.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  final loginRepo loginrepo;
  AuthenticateBloc({required this.loginrepo}) : super(AuthenticateInitial()) {}

  @override
  Stream<AuthenticateState> mapEventToState(AuthenticateEvent event) async* {
    if (event is AppStarted) {
      yield AuthenticateInitial();
      await Future.delayed(const Duration(seconds: 3));
      final bool hasToken = await loginrepo.hasToken();
      if (hasToken != null) {
        yield AuthenticateAuthenticated();
      } else {
        yield AuthenticateunAuthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticateisLoading();
      await loginrepo.hasToken();
      yield AuthenticateAuthenticated();
    }
    if (event is LoggedOut) {
      yield AuthenticateisLoading();
      await loginrepo.deleteToken();
      yield AuthenticateunAuthenticated();
    }
    if (event is GetProfile) {
      yield ProfileLoading();
      var responsedata = await loginrepo.getdatauser();
      yield ProfileLoaded(responsedata);
    }
    if (event is SubmitProfile) {
      yield ProfileLoading();
      try {
        await loginrepo.saveProfile(
            event.email, event.password, event.passwordbaru);
        yield ProfileSubmited();
      } catch (e) {
        yield ProfileError(error: e.toString());
      }
    }
  }
}
