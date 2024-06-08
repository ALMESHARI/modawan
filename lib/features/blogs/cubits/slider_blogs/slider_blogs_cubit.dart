import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
// import 'package:modawan/features/blogs/data/blog_entity.dart';
import 'package:modawan/features/blogs/data/blog_model.dart';
import 'package:modawan/features/blogs/data/blog_repository.dart';

part 'slider_blogs_state.dart';

class SliderBlogsCubit extends Cubit<SliderBlogsState> {
  final BlogRepository blogRepository;
  SliderBlogsCubit(this.blogRepository) : super(SliderBlogsInitial()) {
    getSliderBlogs();
  }

  Future<void> getSliderBlogs() async {
    emit(SliderBlogsInitial());
    final blogs = await blogRepository.getAllBlogsFromAPI();
    blogs.fold((l) => emit(SliderBlogsError(l.toString())),
        (blogs) => emit(SliderBlogsRetrieved(blogs)));
  }
}
