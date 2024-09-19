import 'dart:async';
import 'dart:io';
import 'package:blog/core/usecases/usecases.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/usecases/get_blogs.dart';
import 'package:blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetBlogs _getBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetBlogs getBlogs,
  })  : _uploadBlog = uploadBlog,
        _getBlogs = getBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoadingState());
    });

    on<BlogUploadEvent>(_handleBlogUploadEvent);
    on<BlogFetchEvent>(_handleBlogFetchEvent);
  }

  FutureOr<void> _handleBlogFetchEvent(
    BlogFetchEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getBlogs(NoParams());

    res.fold(
      (l) => emit(BlogErrorState(message: l.message)),
      (r) => emit(BlogFetchedSuccessState(blogs: r)),
    );
  }

  FutureOr<void> _handleBlogUploadEvent(
    BlogUploadEvent event,
    Emitter<BlogState> emit,
  ) async {
    final response = await _uploadBlog(UploadBlogParams(
      title: event.title,
      description: event.description,
      categories: event.categories,
      image: event.image,
      posterId: event.posterId,
    ));

    response.fold(
      (l) => emit(BlogErrorState(message: l.message)),
      (r) => emit(BlogSuccessState(blog: r)),
    );
  }
}
