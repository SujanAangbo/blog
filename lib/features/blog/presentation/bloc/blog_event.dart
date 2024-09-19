part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class BlogUploadEvent extends BlogEvent {
  final String title;
  final String description;
  final File? image;
  final String posterId;
  final List<String> categories;

  BlogUploadEvent({
    required this.title,
    required this.description,
    this.image,
    required this.categories,
    required this.posterId,
  });
}

class BlogFetchEvent extends BlogEvent {}
