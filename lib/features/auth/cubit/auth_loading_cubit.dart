import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_loading_state.dart';
//this whole cubit is just for loading request 

class AuthLoadingCubit extends Cubit<AuthLoadingState> {
  AuthLoadingCubit() : super(AuthLoadingComplete());
}
