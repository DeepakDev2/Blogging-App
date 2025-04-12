import 'dart:io';

import 'package:blogging_app/core/error/exceptions.dart';
import 'package:blogging_app/core/error/failure.dart';
import 'package:blogging_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blogging_app/features/blog/data/model/blog_model.dart';
import 'package:blogging_app/features/blog/domain/entities/blog.dart';
import 'package:blogging_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDatasource blogRemoteDatasource;
  BlogRepositoryImpl(this.blogRemoteDatasource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: "",
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDatasource.uploadBlogImage(
          image: image, blogModel: blogModel);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogRemoteDatasource.uploadBlog(blogModel);
      return Right(uploadedBlog);
    } on ServerExceptions catch (e) {
      print(e.message);
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogData = await blogRemoteDatasource.getAllBlogs();
      return Right(blogData);
    } on ServerExceptions catch (e) {
      return Left(Failure(e.message));
    }
  }
}
