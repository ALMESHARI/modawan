import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/features/auth/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modawan/features/auth/cubit/auth_loading_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // create controllers for email and password
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final authCubit = GetIt.I.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthCubitState>(
      bloc: authCubit,
      listener: (context, state) {
        if (state is AuthFailure && context.mounted) {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.message),
              ),
            );
          });
        }
      },
      child: Scaffold(
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
            BlocBuilder<AuthLoadingCubit, AuthLoadingState>(
              bloc: GetIt.I.get<AuthLoadingCubit>(),
              builder: (context, state) {
                
                return ElevatedButton(
                  onPressed: state is AuthLoadingComplete ? () async {
                    await authCubit.loginWithPassword(
                        emailController.text, passwordController.text);
                    // clear the fields
                    emailController.clear();
                    passwordController.clear();
                  } : null,
                  child: state is AuthLoadingComplete ? Text('Login') : SizedBox(height: 20, width: 20,child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
