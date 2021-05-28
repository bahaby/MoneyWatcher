import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_watcher/bloc/form_submission_status.dart';
import 'package:money_watcher/model/user.dart';
import 'package:money_watcher/service/auth_service.dart';
import 'package:money_watcher/service_locator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final authService = getIt<AuthService>();
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await authService.login(User(
          email: state.email,
          password: state.password,
        ));
        yield state.copyWith(formStatus: SubmissionSuccess());
        yield state.copyWith(formStatus: InitialFormStatus());
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
