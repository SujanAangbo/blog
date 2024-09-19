import 'dart:async';
import 'package:blog/core/common/cubits/user_cubit.dart';
import 'package:blog/core/usecases/usecases.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/domain/usecases/current_user.dart';
import 'package:blog/features/auth/domain/usecases/user_login.dart';
import 'package:blog/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final UserCubit _userCubit;

  AuthBloc(
    this._userSignUp,
    this._userLogin,
    this._currentUser,
    this._userCubit,
  ) : super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoadingState()));
    on<SignUpUserEvent>(handleSignUpUserEvent);
    on<LoginUserEvent>(handleLoginUserEvent);
    on<AuthIsUserLoggedInEvent>(_handleAuthIsUserLoggedIn);
  }

  FutureOr<void> _handleAuthIsUserLoggedIn(
      AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) {
        _userCubit.updateUser(null);
        emit(AuthInitial());
      },
      (r) {
        print(r.name);
        print(r.email);
        print(r.id);
        _userCubit.updateUser(r);
        emit(AuthSuccessState(r));
      },
    );

    // res.foldRight<User>(use, (a, r) {
    //   print(r.name);
    //   print(r.email);
    //   print(r.id);
    //   _userCubit.updateUser(r);
    //   emit(AuthSuccessState(r));
    // });
    // res.fold(
    //   (l) => emit(AuthErrorState(l.message)),
    //
    // );
  }

  FutureOr<void> handleLoginUserEvent(
      LoginUserEvent event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold((l) => emit(AuthErrorState(l.message)), (r) {
      _userCubit.updateUser(r);
      emit(AuthSuccessState(r));
    });
  }

  FutureOr<void> handleSignUpUserEvent(
      SignUpUserEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold((l) => emit(AuthErrorState(l.message)), (r) {
      _userCubit.updateUser(r);
      emit(AuthSuccessState(r));
    });
  }
}
