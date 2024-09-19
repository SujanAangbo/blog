import 'package:blog/core/error/exception.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  
  Session? get userSession;
  
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Session? get userSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (res.user == null) {
        throw ServerException(message: "Unable to login!");
      }

      print('userdata = ${res.user.toString()}');
      return UserModel.fromJson(res.user!.toJson());
    } on AuthException catch(e) {
      throw ServerException(message: e.message);
    }
    catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabaseClient.auth
          .signUp(email: email, password: password, data: {
        "name": name,
      });

      if (res.user == null) {
        throw ServerException(message: "User cannot be registered!");
      }
      print('userdata = ${res.user.toString()}');

      return UserModel.fromJson(res.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {

    try {
      if(userSession == null) {
        return null;
      }

      final userData = await supabaseClient.from("users").select().eq("id", userSession!.user.id);

      return UserModel.fromJson(userData.first);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
    


  }

}
