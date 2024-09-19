import 'dart:developer';
import 'dart:io';
import 'package:blog/core/error/exception.dart';
import 'package:blog/core/error/failure.dart';
import 'package:blog/features/blog/data/data_source/blog_local_data_source.dart';
import 'package:blog/features/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/network/connection_checker.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource _blogRemoteDataSource;
  final BlogLocalDataSource _blogLocalDataSource;
  final ConnectionChecker _connectionChecker;

  BlogRepositoryImpl({
    required BlogRemoteDataSource blogRemoteDataSource,
    required BlogLocalDataSource blogLocalDataSource,
    required ConnectionChecker connectionChecker,
  })  : _blogRemoteDataSource = blogRemoteDataSource,
        _blogLocalDataSource = blogLocalDataSource,
        _connectionChecker = connectionChecker;

  @override
  Future<Either<Failure, List<Blog>>> getBlogs() async {
    try {
      if (!await _connectionChecker.isConnected()) {
        final blogs = _blogLocalDataSource.getBlogsFromCache();
        return right(blogs);
      }

      final blogs = await _blogRemoteDataSource.getBlogs();
      _blogLocalDataSource.loadBlogsToCache(blogs);
      log('blogs: $blogs');
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Blog>> createBlog({
    required String title,
    required String description,
    File? image,
    required List<String> categories,
    required String posterId,
  }) async {
    try {
      if (!await _connectionChecker.isConnected()) {
        return left(
            Failure(message: "No internet connection. Try again later!"));
      }

      String? imageUrl;
      String blogId = const Uuid().v1();

      if (image != null) {
        imageUrl = await _blogRemoteDataSource.uploadBlogImage(
          blogId: blogId,
          image: image,
        );
      } else {
        imageUrl = null;
      }

      final blog = BlogModel(
        id: blogId,
        title: title,
        description: description,
        image: imageUrl,
        categories: categories,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: null,
        posterId: posterId,
      );

      print('blog: $blog');

      Blog updatedBlog = await _blogRemoteDataSource.uploadBlog(blog: blog);

      print("uploaded blog: $updatedBlog");
      return right(updatedBlog);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
