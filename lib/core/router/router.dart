import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/features/auth/UI/login_page.dart';
import 'package:modawan/features/auth/cubit/auth_router_cubit.dart';
import 'package:modawan/features/blogs/UIs/home.dart';
import 'package:modawan/image_upload_page.dart';
import 'package:modawan/splash_page.dart';
import 'package:go_router/go_router.dart';

// class AppRouter {
//   static const String initialRoute = '/';
//   static final routes = <String, WidgetBuilder>{
//     '/splash': (_) => const SplashPage(),
//     '/login': (_) => LoginPage(),
//     '/home': (_) => const HomePage(),
//     '/image_uploader_test': (_) => const ImageUploadPage(),
//   };

//   static clearAndPush(BuildContext context, String routeName) {
//     Navigator.pushNamedAndRemoveUntil(
//         context, routeName, (Route<dynamic> route) => false);
//   }
// }

// BlocBuilder<AuthRouterCubit, AuthRouterState?> authRouteBuilder() {
//   final authCubit = GetIt.I.get<AuthRouterCubit>();

//   return BlocBuilder(
//     bloc: authCubit,
//     buildWhen: (previous, current) {
//       return previous.runtimeType != current.runtimeType;
//     },
//     builder: (context, state) {
//       Widget buildPage(AuthRouterState state) {
       
//       }
//       return AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: buildPage(state!));
    
//     },
//   );
// }


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
  redirect: (context, routerState) {
    final state = GetIt.I.get<AuthRouterCubit>().state;
      if (state is Authenticated) {
      return '/home';
    } else if (state is Unauthenticated) {
      return '/login'	;
    } else {
      return '/';
    }
  },
);
