import 'package:modawan/features/auth/UI/login_page.dart';
import 'package:modawan/features/blogs/widgets/home_page.dart';
import 'package:modawan/features/profile/widgets/setup_profile_page.dart';
import 'package:modawan/image_upload_page.dart';
import 'package:modawan/core/components/splash_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/UI/redirect_page.dart';
import '../../features/blogs/widgets/home.dart';

final appRouter = GoRouter(
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
      path: '/home2',
      builder: (context, state) => HomePage2(),
    ),
    GoRoute(
        path: '/image', builder: (context, state) => const ImageUploadPage()),
    GoRoute(
        path: '/setup_profile',
        // without transition
        pageBuilder: (context, state) => NoTransitionPage(child: SetupProfilePage())),
    
  ],
);
