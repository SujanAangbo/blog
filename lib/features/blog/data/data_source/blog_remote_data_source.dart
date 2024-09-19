import 'dart:io';

import 'package:blog/core/error/exception.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog({required BlogModel blog});

  Future<String> uploadBlogImage({
    required String blogId,
    required File image,
  });

  Future<List<BlogModel>> getBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient _supabaseClient;

  BlogRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      final res =
          await _supabaseClient.from("blogs").select("*, users(name, email)");

      print('res :$res');

      return res
          .map((e) => BlogModel.fromJson(e).copyWith(
                posterName: e['users']['name'],
                posterEmail: e['users']['email'],
              ))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async {
    try {
      print('inside upload blog');
      final res =
          await _supabaseClient.from("blogs").insert(blog.toJson()).select();
      print('res: $res');
      return BlogModel.fromJson(res.first);
    } on PostgrestException catch (e) {
      print(e.message);
      throw ServerException(message: e.message);
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required String blogId, required File image}) async {
    try {
      final result = await _supabaseClient.storage
          .from("blog_image")
          .upload(blogId, image);
      print('Uploaded result: $result');

      return _supabaseClient.storage.from("blog_image").getPublicUrl(blogId);
    } on StorageException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
