import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sistem_kearsipan/repository/loginRepo.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final loginRepo loginrepo;
  LoginBloc({required this.loginrepo}) : super(LoginInitial()) {
    assert(loginrepo != null);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginCheckValid) {
      final bool isFormValid =
          event.username.isNotEmpty && event.password.isNotEmpty;

      yield LoginValidate(formValid: isFormValid);
    }

    if (event is LoginSubmitted) {
      yield LoginLoading();
      try {
        await loginrepo.authenticate(event.username, event.password);
        yield LoginInitial();
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }
  }
}
