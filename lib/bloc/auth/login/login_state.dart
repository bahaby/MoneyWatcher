part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  LoginState({
    this.formStatus = const InitialFormStatus(),
    this.email = "",
    this.password = "",
  });
  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
      );
  @override
  List<Object> get props => [email, password, formStatus];

  bool get isValidEmail {
    if (email.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  bool get isValidPassword => password.length > 0;
}
