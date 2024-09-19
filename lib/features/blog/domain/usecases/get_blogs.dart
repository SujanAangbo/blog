import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecases/usecases.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlogs implements Usecases<List<Blog>, NoParams> {
  final BlogRepository _blogRepository;

  GetBlogs({
    required BlogRepository blogRepository,
  }) : _blogRepository = blogRepository;

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await _blogRepository.getBlogs();
  }
}
