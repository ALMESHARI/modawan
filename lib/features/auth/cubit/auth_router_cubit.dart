import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_router_state.dart';
//this whole cubit is just for loading request

class AuthRouterCubit extends Cubit<AuthRouterState> {
  AuthRouterCubit() : super(InitialRouteState());
}
