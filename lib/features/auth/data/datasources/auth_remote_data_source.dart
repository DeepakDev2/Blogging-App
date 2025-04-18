import 'package:blogging_app/core/error/exceptions.dart';
import 'package:blogging_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final res = await supabaseClient.auth
          .signUp(password: password, email: email, data: {
        "name": name,
      });
      if (res.user == null) {
        throw ServerExceptions("User is null");
      }
      return UserModel.fromJson(res.user!.toJson());
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final res = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      if (res.user == null) {
        throw ServerExceptions("User is null");
      }
      return UserModel.fromJson(res.user!.toJson())
          .copyWith(email: res.user!.email);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession == null) {
        return null;
      }
      final userData = await supabaseClient
          .from("profiles")
          .select()
          .eq("id", currentUserSession!.user.id);
      return UserModel.fromJson(userData.first)
          .copyWith(email: currentUserSession!.user.email);
      // return ;
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
