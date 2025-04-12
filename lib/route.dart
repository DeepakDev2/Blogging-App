import 'package:blogging_app/features/auth/presentation/pages/login_page.dart';
import 'package:blogging_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blogging_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    SignInPage.routeName: (context) => const SignInPage(),
    SignupPage.routeName: (context) => const SignupPage(),
    AddNewBlogPage.routeName: (_) => const AddNewBlogPage(),
  };
}
