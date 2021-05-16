part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}

class RegisterNameChanged extends RegisterEvent {
  final String fullName;

  RegisterNameChanged({required this.fullName});
  @override
  List<Object> get props => [fullName];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {}
