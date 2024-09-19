part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignUpUserEvent extends AuthEvent {
  final String email, name, password;

  SignUpUserEvent(this.email, this.name, this.password);
}

class LoginUserEvent extends AuthEvent {
  final String email, password;

  LoginUserEvent(this.email, this.password);
}

class AuthIsUserLoggedInEvent extends AuthEvent {}
