import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/app_pallet.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/pages/blog_detail_page.dart';
import 'package:blog/features/blog/presentation/pages/create_blog_page.dart';
import 'package:blog/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add_circled),
            onPressed: () {
              Navigator.push(context, CreateBlogPage.route());
            },
          ),
        ],
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return const Loader();
          } else if (state is BlogErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 16),
              ),
            );
          } else if (state is BlogFetchedSuccessState) {
            List<Blog> blogs = state.blogs;
            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                return BlogCard(
                  blog: blogs[index],
                  color: index % 2 == 0
                      ? AppPallet.gradient1
                      : AppPallet.gradient2,
                  onPressed: () {
                    Navigator.push(
                      context,
                      BlogDetailPage.route(blogs[index]),
                    );
                  },
                );
              },
            );
          }
          return const Center(
            child: Text("Something went wrong"),
          );
        },
      ),
    );
  }
}
