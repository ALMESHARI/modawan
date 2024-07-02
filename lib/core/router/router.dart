import 'package:flutter/material.dart';
import 'package:modawan/features/auth/UI/login_page.dart';
import 'package:modawan/features/blog_editor/widgets/blog_editor_page.dart';
import 'package:modawan/features/blogs/widgets/home_page.dart';
import 'package:modawan/features/profile/widgets/setup_profile_page.dart';
import 'package:modawan/core/components/splash_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/UI/redirect_page.dart';

final appRouter = GoRouter(
  // observers: [GoRouterObserver()],
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      // ignore: prefer_const_constructors
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
        path: '/auth_redirect',
        builder: (context, state) => AuthRedirectPage()),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
        path: '/setup_profile',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SetupProfilePage())),
    GoRoute(path: '/blog_editor', builder: (context, state) => BlogEditorPage()),
  ],
);

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(' didPush: $route');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('MyTest didPop: $route');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('MyTest didRemove: $route');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print('MyTest didReplace: $newRoute');
  }
}
