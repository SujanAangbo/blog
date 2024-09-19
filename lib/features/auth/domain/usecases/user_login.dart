import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecases/usecases.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements Usecases<User, UserLoginParams> {
  final AuthRepository _authRepository;

  UserLogin(this._authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await _authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  String email;
  String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
