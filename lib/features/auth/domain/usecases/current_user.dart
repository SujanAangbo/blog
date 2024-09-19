
import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecases/usecases.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecases<User, NoParams> {

  final AuthRepository _authRepository;

  CurrentUser(this._authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await _authRepository.getCurrentUser();
  }

}
