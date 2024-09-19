import 'dart:io';

import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecases/usecases.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements Usecases<Blog, UploadBlogParams> {
  final BlogRepository _blogRepository;

  UploadBlog({required BlogRepository blogRepository})
      : _blogRepository = blogRepository;

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await _blogRepository.createBlog(
      title: params.title,
      description: params.description,
      categories: params.categories,
      image: params.image,
      posterId: params.posterId,
    );
  }
}

class UploadBlogParams {
  String title;
  String description;
  File? image;
  String posterId;
  List<String> categories;

  UploadBlogParams({
    required this.title,
    required this.description,
    this.image,
    required this.categories,
    required this.posterId,
  });
}
