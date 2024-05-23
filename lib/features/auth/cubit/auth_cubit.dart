import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/core/failures.dart';
import 'package:modawan/features/auth/cubit/auth_loading_cubit.dart';
import 'package:modawan/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit(this.loadingCubit) : super(AuthInitial()) {
    if (supabase.auth.currentUser != null) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }

    // supabase.auth.onAuthStateChange.listen((data) {
    //   final AuthChangeEvent event = data.event;
    //   if (event == AuthChangeEvent.signedIn) {
    //     emit(AuthSuccess());
    //   }
    // });
  }

  final AuthLoadingCubit loadingCubit;

  Future<void> loginWithPassword(String email, String password) async {
    try {
      loadingCubit.emit(AuthLoadingInProgress());
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      loadingCubit.emit(AuthLoadingComplete());
      if (res.user == null) {
        emit(AuthFailure(getFailure('an authentication error occurs')));
      } else {
        emit(Authenticated());
      }
    } catch (e) {
      loadingCubit.emit(AuthLoadingComplete());
      emit(AuthFailure(getFailureFromException(e as Exception)));
    }
  }

  User? getCurrentUser() {
    final user = supabase.auth.currentUser;
    if (user == null) {
      emit(AuthFailure(getFailure('an authentication error occurs')));
      return null;
    } else {
      return user;
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthFailure(getFailureFromException(e as Exception)));
    }
  }
}
