import '../../profile/repository/profile_model.dart';
import 'blog_model.dart';
import 'topic_model.dart';

class BlogEntity {
  final BlogModel blogData;
  final ProfileModel writerData;
  final List<TopicModel> topicsData;

  BlogEntity({
    required this.blogData,
    required this.writerData,
    required this.topicsData,
  });
}
