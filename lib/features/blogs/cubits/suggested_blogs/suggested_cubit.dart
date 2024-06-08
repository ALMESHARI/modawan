import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'suggested_state.dart';

class SuggestedBlogsCubit extends Cubit<SuggestedBlogsState> {
  SuggestedBlogsCubit() : super(SuggestedBlogsInitial());
}
