import 'package:flutter/material.dart';
import 'package:modawan/core/router.dart';
import 'package:modawan/dependency_container.dart';
import 'package:modawan/theme/theme_constants.dart';
import 'package:modawan/theme/theme_manager.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRouter.routes,
      title: 'Modawan',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      
      home: authRouteBuilder(),
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
  setupDependencyContainer();
}
