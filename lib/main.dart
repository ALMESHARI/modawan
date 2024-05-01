import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    debug: true,
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: const MyHomePage(),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add_alert),
              onPressed: () async {
                final data = await supabase.from('Blogs').select('id');
                print(data);

                // show a dialog that ask the user to enter his name
              },
            ),
          ],
          title: const Text('Hello dsfjssdssdfssdfssdfsddsdfsld'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: const Center(
        child: Text(
          'Hello, World!',
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
