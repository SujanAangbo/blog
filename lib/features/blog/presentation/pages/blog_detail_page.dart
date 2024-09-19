import 'package:blog/core/utils/date_formatter.dart';
import 'package:blog/core/utils/reading_time.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogDetailPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogDetailPage(blog: blog),
      );

  final Blog blog;

  const BlogDetailPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "By ${blog.posterName}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${formatDateByDDMMMYYYY(blog.updatedAt ?? blog.createdAt)} . ${calculateReadingTime(blog.description + blog.title)} min",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                if (blog.image != null) ...[
                  ClipRRect(
                    child: Image.network(blog.image!),
                  ),
                  const SizedBox(height: 10),
                ],
                Text(
                  blog.description,
        
                  style: const TextStyle(
                    fontSize: 16,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
