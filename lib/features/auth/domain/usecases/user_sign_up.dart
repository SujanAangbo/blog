import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecases/usecases.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecases<User, UserSignUpParams> {
  final AuthRepository _authRepository;

  UserSignUp(this._authRepository);


  @override
  Future<Either<Failure, User>> call(params) async {
    return await _authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name, email, password;

  UserSignUpParams(
      {required this.name, required this.email, required this.password,});
}
