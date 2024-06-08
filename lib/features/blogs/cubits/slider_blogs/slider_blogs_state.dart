part of 'slider_blogs_cubit.dart';

@immutable
sealed class SliderBlogsState {}

final class SliderBlogsInitial extends SliderBlogsState {}

// retrieved state 
final class SliderBlogsRetrieved extends SliderBlogsState {
  // final List<BlogEntity> blogs;
  final List<BlogModel> blogs;

  SliderBlogsRetrieved(this.blogs);
}

// error state
final class SliderBlogsError extends SliderBlogsState {
  final String message;

  SliderBlogsError(this.message);
}