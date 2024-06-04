import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modawan/core/failures.dart';
import 'package:modawan/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_manager_state.dart';

// this cubit is the main cubit  for authentication where all the requests
// are made and the state is managed based in the response from the server
// the cubit is also responsible for notify the loading state during the request
// note that the responsiblity of the navigation is not in this cubit,
// it is in the router which is listening to supabase auth state
class AuthManagerCubit extends Cubit<AuthManagerCubitState> {
  AuthManagerCubit() : super(AuthInitial());

  Future<void> loginWithPassword(String email, String password) async {
    try {
      emit(AuthLoading());
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user == null) {
        emit(AuthFailure(getFailure('an authentication error occurs')));
        // routerCubit.emit(Unauthenticated());
      } else {
        emit(AuthSuccess());
        // routerCubit.emit(Authenticated());
      }
    } catch (e) {
      // routerCubit.emit(Unauthenticated());
      emit(AuthFailure(getFailureFromException(e as Exception)));
    }
  }

  Future<void> loginWithEmailOTP(String email) async {
    try {
      emit(AuthLoading());
      await supabase.auth.signInWithOtp(
        email: email,
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
      );
      emit(AuthOTPSent(email));
    } catch (e) {
      emit(AuthFailure(getFailureFromException(e as Exception)));
      // routerCubit.emit(Unauthenticated());
    }
  }

  Future<void> googleSignIn(bool isWeb) async {
    if (isWeb) {
      await _googleSignInWeb();
    } else {
      await _googleSignInMobile();
    }
  }

  Future<void> _googleSignInWeb() async {
    try{
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
    );
    } catch (e) {
      emit(AuthFailure(getFailure(e.toString())));
    }
  }

  Future<void> _googleSignInMobile() async {
    try {
      emit(AuthLoading());
      final webClientId = dotenv.env['google_web_client_id']!;
      final iosClientId = dotenv.env['google_ios_client_id']!;
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(AuthInitial());
        return;
      }
      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw Exception('No access valid token');
      }
      if (idToken == null) {
        throw Exception('No ID Token found.');
      }

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      emit(AuthInitial());
      await googleSignIn.disconnect();
    } catch (e) {
      emit(AuthFailure(getFailure(e.toString())));
    }
  }

  User? getCurrentUser() {
    final user = supabase.auth.currentUser;
    if (user == null) {
      emit(AuthFailure(getFailure('an authentication error occurs')));
      // routerCubit.emit(Unauthenticated());
      return null;
    } else {
      return user;
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      emit(AuthInitial());
      // routerCubit.emit(Unauthenticated());
    } catch (e) {
      emit(AuthFailure(getFailureFromException(e as Exception)));
    }
  }

  void clearState() {
    emit(AuthInitial());
  }
}
