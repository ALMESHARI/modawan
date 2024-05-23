import 'package:flutter/material.dart';
import 'package:modawan/core/router.dart';
import 'package:modawan/dependency_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    debug: true,
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  setupDependencyContainer();
  runApp(MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRouter.routes,
      title: 'Modawan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: authRouteBuilder(),
    );
  }

  
}
