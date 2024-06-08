import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'topics_state.dart';

class TopicsCubit extends Cubit<TopicsState> {
  TopicsCubit() : super(TopicsInitial());
}
