import 'package:blogging_app/bloc/auth_bloc.dart';
import 'package:blogging_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blogging_app/core/secrets/app_secrets.dart';
import 'package:blogging_app/core/usercase/usecase.dart';
import 'package:blogging_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blogging_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blogging_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blogging_app/features/auth/domain/usecases/current_user.dart';
import 'package:blogging_app/features/auth/domain/usecases/user_signin.dart';
import 'package:blogging_app/features/auth/domain/usecases/user_signup.dart';
import 'package:blogging_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blogging_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blogging_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blogging_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blogging_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blogging_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.projectUrl,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  _initAuth();
  _initBlog();
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignup(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignIn(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CurrentUser(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      appUserCubit: serviceLocator(),
      userSignup: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
    ),
  );
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDatasource>(
      () => BlogRemoteDatasourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogRepository>(
        () => BlogRepositoryImpl(serviceLocator()))
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    ..registerLazySingleton(() =>
        BlogBloc(getAllBlogs: serviceLocator(), uploadBlog: serviceLocator()));
}
