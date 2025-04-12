import 'package:blogging_app/core/error/failure.dart';
import 'package:blogging_app/core/usercase/usecase.dart';
import 'package:blogging_app/core/entities/user.dart';
import 'package:blogging_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements Usecase<User, UserSignInpParams> {
  final AuthRepository authRepository;

  const UserSignIn({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UserSignInpParams params) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInpParams {
  final String email;
  final String password;

  UserSignInpParams({required this.email, required this.password});
}
