part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoggedInState extends UserState {
  final User user;

  UserLoggedInState({required this.user});
}

final class UserLoggedOutState extends UserState {}
