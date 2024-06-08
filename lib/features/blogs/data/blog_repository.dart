import 'package:modawan/core/failures.dart';
import 'package:modawan/features/blogs/data/blog_model.dart';
import 'package:modawan/main.dart';
import 'package:dartz/dartz.dart';

class BlogRepository {
  Future<Either<Failure, List<BlogModel>>> getAllBlogsFromAPI() async {
    try {
      final result = await supabase.from('blogs').select();
      print(result);

      final blogs = result.map((e) {
        print(e);
        return BlogModel.fromJson(e);
      }).toList();
      return Right(blogs);
    } catch (e) {
      return Left(getFailureFromException(e));
    }
  }

  // get blogs from cache
}
