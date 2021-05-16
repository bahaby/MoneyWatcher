part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String fullName;
  final FormSubmissionStatus formStatus;

  RegisterState({
    this.fullName = "",
    this.formStatus = const InitialFormStatus(),
    this.email = "",
    this.password = "",
  });
  RegisterState copyWith({
    String? email,
    String? fullName,
    String? password,
    FormSubmissionStatus? formStatus,
  }) =>
      RegisterState(
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
      );
  @override
  List<Object> get props => [email, fullName, password, formStatus];

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

  bool get isValidPassword => password.length > 5;
  bool get isValidName => password.length > 5;
}
