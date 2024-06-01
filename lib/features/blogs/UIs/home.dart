import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:modawan/core/widgets/custom_containers.dart';
import 'package:modawan/features/auth/cubit/auth_manager_cubit.dart';
import 'package:modawan/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? data;

  final authCubit = GetIt.I.get<AuthManagerCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          // button to change mode
          IconButton(
            onPressed: () {
              themeManager.toggleTheme();
            },
            icon: const Icon(Icons.brightness_4),
          ),
          IconButton(
            onPressed: () async {
              await authCubit.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (data != null) Text(data!),
              Text(
                'Welcome ${supabase.auth.currentUser!.email} to Supabase Flutter',
              ),
              SizedBox(height: 20),
              GlassContainer(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                key: const Key('show_profile'),
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
                key: const Key('image_upload_test'),
                onPressed: () async {
                  context.push('/image');
                },
                child: const Text('Image Upload Test'),
              ),
            ]),
      ),
    );
  }
}
