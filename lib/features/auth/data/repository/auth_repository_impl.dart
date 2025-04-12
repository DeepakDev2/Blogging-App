import 'package:blogging_app/core/error/exceptions.dart';
import 'package:blogging_app/core/error/failure.dart';
import 'package:blogging_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blogging_app/features/auth/data/models/user_model.dart';
import 'package:blogging_app/core/entities/user.dart';
import 'package:blogging_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
// import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, UserModel>> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      // print("Helloo");
      final user = await authRemoteDataSource.signInWithEmailAndPassword(
          email: email, password: password);
      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // print("Helloo");
      final userModel = await authRemoteDataSource.signUpWithEmailAndPassword(
          name: name, email: email, password: password);
      return right(userModel);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("User not logged in."));
      }
      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
