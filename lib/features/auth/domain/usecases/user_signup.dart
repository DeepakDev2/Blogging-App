import 'package:blogging_app/core/error/failure.dart';
import 'package:blogging_app/core/usercase/usecase.dart';
import 'package:blogging_app/core/entities/user.dart';
import 'package:blogging_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements Usecase<User, UserSingUpParams> {
  final AuthRepository authRepository;
  UserSignup(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSingUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSingUpParams {
  final String email;
  final String password;
  final String name;
  UserSingUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
