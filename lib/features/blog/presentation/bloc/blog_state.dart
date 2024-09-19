part of 'blog_bloc.dart';

@immutable
sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {}

final class BlogLoadingState extends BlogState {}

final class BlogSuccessState extends BlogState {
  final Blog blog;
  const BlogSuccessState({required this.blog});
}

final class BlogFetchedSuccessState extends BlogState {
  final List<Blog> blogs;
  const BlogFetchedSuccessState({required this.blogs});
}

final class BlogErrorState extends BlogState {
  final String message;
  const BlogErrorState({this.message = "An error occurred!"});
}
