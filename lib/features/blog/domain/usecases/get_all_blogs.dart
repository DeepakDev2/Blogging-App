import 'package:blogging_app/core/error/failure.dart';
import 'package:blogging_app/core/usercase/usecase.dart';
import 'package:blogging_app/features/blog/domain/entities/blog.dart';
import 'package:blogging_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
