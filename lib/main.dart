import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modawan/core/router/router.dart';
import 'package:modawan/dependency_container.dart';
import 'package:modawan/core/theme/theme_constants.dart';
import 'package:modawan/core/theme/theme_manager.dart';
import 'package:modawan/features/profile/cubit/profile_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await _initialization();
  runApp(const MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListner);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(() {
      themeListner();
    });
    super.initState();
  }

  themeListner() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Modawan',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
    );
  }
}

Future<void> _initialization() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    debug: true,
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  await setupDependencyContainer();

  await _initializeRouting();
  await Hive.initFlutter();
  await Hive.openBox('settings');
}

Future<void> _initializeRouting() async {
  if (supabase.auth.currentUser != null) {
    final profileCubit = GetIt.I.get<ProfileCubit>();

    bool isFinishSetup =
        await profileCubit.isFinishSetup(supabase.auth.currentUser!.id);
    print('this is finish setup $isFinishSetup');
    if (!isFinishSetup) {
      appRouter.go('/setup_profile');
    } else {
      appRouter.go('/home');
    }
  } else {
    appRouter.go('/login');
  }

  supabase.auth.onAuthStateChange.listen((data) async{
    final AuthChangeEvent event = data.event;
    if (event == AuthChangeEvent.signedIn) {

      final profileCubit = GetIt.I.get<ProfileCubit>();

    bool isFinishSetup =
        await profileCubit.isFinishSetup(supabase.auth.currentUser!.id);
    print('this is finish setup $isFinishSetup');
    if (!isFinishSetup) {
      appRouter.go('/setup_profile');
    } else {
      appRouter.go('/home');
    }
    }
    if (event == AuthChangeEvent.signedOut) {
      appRouter.go('/login');
    }
  }, onError: (e) {
    appRouter.go('/login');
  });
}
