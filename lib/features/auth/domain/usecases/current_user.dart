import 'package:blogging_app/core/error/failure.dart';
import 'package:blogging_app/core/usercase/usecase.dart';
import 'package:blogging_app/core/entities/user.dart';
import 'package:blogging_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;
  const CurrentUser({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
