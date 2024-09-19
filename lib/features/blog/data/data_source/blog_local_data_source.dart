import 'package:hive/hive.dart';
import '../models/blog_model.dart';

abstract interface class BlogLocalDataSource {
  void loadBlogsToCache(List<BlogModel> blogs);
  List<BlogModel> getBlogsFromCache();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> getBlogsFromCache() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        final blogMap = box.get(i.toString());
        blogs.add(BlogModel.fromJson(blogMap));
      }
    });

    return blogs;
  }

  @override
  void loadBlogsToCache(List<BlogModel> blogs) {
    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    });
  }
}
