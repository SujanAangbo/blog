import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:blog/core/common/entities/user.dart';
import 'package:blog/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      if (!await connectionChecker.isConnected()) {

        if (remoteDataSource.userSession == null) {
          return left(Failure(message: "User is not logged in!"));
        }

        final session = remoteDataSource.userSession;
        if (session == null) {
          return left(Failure(message: "User is not logged in!"));
        }

        return right(
          User(session.user.id, session.user.email ?? "",
              session.user.userMetadata?['name'] ?? ""),
        );
      }

      UserModel? user = await remoteDataSource.getCurrentUser();
      if (user == null) {
        return left(Failure(message: "User is not logged in!"));
      }

      return right(user);
    } on ServerException catch (e) {
      print('error: ${e.message}');
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(
          Failure(message: "No internet connection. Please try again"),
        );
      }

      UserModel res = await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(
        Failure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(
          Failure(message: "No internet connection. Please try again"),
        );
      }

      UserModel userId = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(userId);
    } on ServerException catch (e) {
      return left(
        Failure(message: e.message),
      );
    }
  }
}
