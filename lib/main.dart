import 'package:blogging_app/bloc/auth_bloc.dart';
import 'package:blogging_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blogging_app/core/theme/theme.dart';
import 'package:blogging_app/features/auth/presentation/pages/login_page.dart';
import 'package:blogging_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogging_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blogging_app/init_dependency.dart';
import 'package:blogging_app/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final supabase = await Supabase.initialize(
  //   url: AppSecrets.projectUrl,
  //   anonKey: AppSecrets.anonKey,
  // );
  await initDependency();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const SignInPage();
        },
      ),
    );
  }
}
