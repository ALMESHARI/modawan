import 'package:flutter/material.dart';
import 'package:modawan/core/failures.dart';
import 'package:modawan/features/auth/cubit/auth_router_cubit.dart';
import 'package:modawan/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_manager_state.dart';

// this cubit is the main cubit  for authentication where all the requests
// are made and the state is managed based in the response from the server
// the cubit is also responsible for notify the loading state during the request
// and also to manage emiting states to another cubit called AuthRouterCubit
// which is responsible only for the navigation based on the authentication state
class AuthManagerCubit extends Cubit<AuthCubitState> {
  AuthManagerCubit(this.routerCubit) : super(AuthInitial()) {
    if (supabase.auth.currentUser != null) {
      emit(AuthSuccess());
      routerCubit.emit(Authenticated());
    } else {
      routerCubit.emit(Unauthenticated());
    }

    // supabase.auth.onAuthStateChange.listen((data) {
    //   final AuthChangeEvent event = data.event;
    //   if (event == AuthChangeEvent.signedIn) {
    //     emit(AuthSuccess());
    //   }
    // });
  }

  final AuthRouterCubit routerCubit;

  Future<void> loginWithPassword(String email, String password) async {
    try {
      emit(AuthLoading());
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user == null) {
        emit(AuthFailure(getFailure('an authentication error occurs')));
        routerCubit.emit(Unauthenticated());
      } else {
        emit(AuthSuccess());
        routerCubit.emit(Authenticated());
      }
    } catch (e) {
      routerCubit.emit(Unauthenticated());
      emit(AuthFailure(getFailureFromException(e as Exception)));
    }
  }

  User? getCurrentUser() {
    final user = supabase.auth.currentUser;
    if (user == null) {
      emit(AuthFailure(getFailure('an authentication error occurs')));
      routerCubit.emit(Unauthenticated());
      return null;
    } else {
      return user;
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      emit(AuthInitial());
      routerCubit.emit(Unauthenticated());
    } catch (e) {
      emit(AuthFailure(getFailureFromException(e as Exception)));
    }
  }

  void clearFailure() {
    emit(AuthInitial());
  }
}
