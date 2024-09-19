import 'package:blog/core/theme/app_pallet.dart';
import 'package:blog/core/utils/reading_time.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  final Function() onPressed;

  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 10,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: blog.categories
                  .map(
                    (category) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        label: Text(category),
                        side: BorderSide(color: color),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 4),
            Text(
              blog.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              blog.description.trim(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppPallet.whiteColor.withOpacity(0.7),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
                "Approx Reading Time: ${calculateReadingTime(blog.description + blog.title)} min"),
          ],
        ),
      ),
    );
  }
}
