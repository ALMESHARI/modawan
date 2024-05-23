import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/features/auth/cubit/auth_cubit.dart';
import 'package:modawan/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? data;

  final authCubit = GetIt.I.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async {
              await authCubit.signOut();
            },
            icon: const Icon(Icons.logout),
          ),],
      ),
      body: Column(children: [
        if (data != null) Text(data!),
        Text(
          'Welcome ${supabase.auth.currentUser!.email} to Supabase Flutter',
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            final resdata = await supabase.from('profiles').select();
            print(resdata);
            setState(() {
              data = resdata.toString();
            });
          },
          child: const Text('Show profile'),
        ),
        SizedBox(height: 20),
        // navigate to imageupload page
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/image_uploader_test');
          },
          child: const Text('Image Upload Test'),
        ),
      ]),
    );
  }
}
