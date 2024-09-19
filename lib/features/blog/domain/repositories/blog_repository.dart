import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> createBlog({
    required String title,
    required String description,
    File? image,
    required List<String> categories,
    required String posterId,
  });
  Future<Either<Failure, List<Blog>>> getBlogs();
}
