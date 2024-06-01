import 'package:modawan/features/auth/UI/login_page.dart';
import 'package:modawan/features/blogs/UIs/home.dart';
import 'package:modawan/image_upload_page.dart';
import 'package:modawan/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void initializeRouting(supabase) {
  if (supabase.auth.currentUser != null) {
    appRouter.go('/home');
  } else {
    appRouter.go('/login');
  }

  supabase.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;
    if (event == AuthChangeEvent.signedIn) {
      appRouter.go('/home');
    }
    if (event == AuthChangeEvent.signedOut) {
      appRouter.go('/login');
    }
  }, onError: (e) {
    appRouter.go('/login');
  });
}

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
    GoRoute(
      path: '/image',
      builder: (context, state) => const ImageUploadPage()),
  ],
);
