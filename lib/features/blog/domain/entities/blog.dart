import 'package:blog/features/blog/data/models/blog_model.dart';

class Blog {
  String id;
  String title;
  String description;
  String? image;
  String posterId;
  List<String> categories;
  String? updatedAt;
  String createdAt;
  String? posterName;
  String? posterEmail;

  Blog({
    required this.id,
    required this.title,
    required this.description,
    required this.posterId,
    this.image,
    required this.categories,
    this.updatedAt,
    required this.createdAt,
    this.posterName,
    this.posterEmail,
  });


}
