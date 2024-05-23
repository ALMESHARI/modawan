import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/features/auth/UI/loginPage.dart';
import 'package:modawan/features/auth/cubit/auth_cubit.dart';
import 'package:modawan/features/blogs/UIs/home.dart';
import 'package:modawan/image_upload_page.dart';
import 'package:modawan/splashPage.dart';

class AppRouter {
  static const String initialRoute = '/';
  static final routes = <String, WidgetBuilder>{
    '/splash': (_) => SplashPage(),
    '/login': (_) => LoginPage(),
    '/home': (_) => const HomePage(),
    '/image_uploader_test': (_) => ImageUploadPage(),
  };

  static clearAndPush(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(
        context, routeName, (Route<dynamic> route) => false);
  }
}

BlocBuilder<AuthCubit, Object?> authRouteBuilder() {
  final authCubit = GetIt.I.get<AuthCubit>();

  return BlocBuilder(
    bloc: authCubit,
    buildWhen: (previous, current) {

      if ((previous is AuthFailure) && current is AuthFailure) {
        // check if the failure message is the same
        return previous.failure.message != current.failure.message;
      }
      if (previous is Unauthenticated && current is AuthFailure) {
        // check if the user is the same
        return false;
      }
      return previous.runtimeType != current.runtimeType;
    },
    builder: (context, state) {
      //show snackbar if login fails
      print('rebuild form main ${state.runtimeType}');
      if (state is Authenticated) {
        return HomePage();
      } else if (state is Unauthenticated || state is AuthFailure) {
        return LoginPage();
      } else {
        return SplashPage();
      }
    },
  );
}
