import 'package:blog/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.description,
    required super.categories,
    required super.createdAt,
    required super.posterId,
    super.image,
    super.updatedAt,
    super.posterName,
    super.posterEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'category': categories,
      'poster_id': posterId,
      'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      posterId: json['poster_id'] ?? "",
      image: json['image'],
      categories: List<String>.from(json['category'] ?? []),
      updatedAt: json['updated_at'],
      createdAt: json['created_at'] ?? "",
    );
  }

  // toString method
  @override
  String toString() {
    return 'BlogModel(id: $id, title: $title, description: $description, image: $image, categories: $categories, updatedAt: $updatedAt, createdAt: $createdAt, posterName: $posterName, posterEmail: $posterEmail)';
  }


  // copyWith method
  BlogModel copyWith({
    String? id,
    String? title,
    String? description,
    String? posterId,
    String? image,
    List<String>? categories,
    String? updatedAt,
    String? createdAt,
    String? posterName,
    String? posterEmail,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      posterId: posterId ?? this.posterId,
      image: image ?? this.image,
      categories: categories ?? this.categories,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      posterName: posterName ?? this.posterName,
      posterEmail: posterEmail ?? this.posterEmail,
    );
  }



}
