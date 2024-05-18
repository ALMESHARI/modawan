import 'package:flutter/material.dart';
import 'package:modawan/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // create controllers for email and password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // create two fields for email and password
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          // create a button to login
          ElevatedButton(
            onPressed: () async {
              try {
                await supabase.auth.signInWithPassword(
                email: emailController.text,
                password: passwordController.text,
              );
              
              Navigator.of(context).pushReplacementNamed('/home');
              } catch (e) {
                // show error message in bottom sheet
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                  ),
                );
              }
              
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
