import 'package:blogging_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogging_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    // context.read<BlogBloc>().add(BlogGetAllBlogs());
    // if(context.read<BlogBloc>().state is )
    // print((context.read<BlogBloc>().state as BlogGetAllBlogsSuccess).blogs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddNewBlogPage.routeName);
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
      // body: BlocConsumer<BlogBloc, BlogState>(builder: (context, state) {
      //   return Center(
      //     child: Text(""),
      //   );
      // }, listener: (context, state) {
      //   if (state is BlogGetAllBlogsSuccess) {
      //     print(
      //         (context.read<BlogBloc>().state as BlogGetAllBlogsSuccess).blogs);
      //   }
      // }),
    );
  }
}
