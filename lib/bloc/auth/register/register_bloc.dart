import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_watcher/bloc/form_submission_status.dart';
import 'package:money_watcher/model/user.dart';
import 'package:money_watcher/service/auth_service.dart';
import 'package:money_watcher/service_locator.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final authService = getIt<AuthService>();
  RegisterBloc() : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is RegisterNameChanged) {
      yield state.copyWith(fullName: event.fullName);
    } else if (event is RegisterPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is RegisterSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await authService.register(User(
          email: state.email,
          fullName: state.fullName,
          password: state.password,
        ));
        yield state.copyWith(formStatus: SubmissionSuccess());
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
