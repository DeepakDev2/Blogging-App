import 'package:blogging_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Paramas> {
  Future<Either<Failure, SuccessType>> call(Paramas params);
}

class NoParams {}
