import 'package:blog/core/common/entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(UserLoggedOutState());
    } else {
      emit(UserLoggedInState(user: user));
    }
  }
}
