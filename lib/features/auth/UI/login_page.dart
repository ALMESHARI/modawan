import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/core/widgets/background.dart';
import 'package:modawan/core/widgets/custom_containers.dart';
import 'package:modawan/core/widgets/modawan_logo.dart';
import 'package:modawan/features/auth/cubit/auth_manager_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // create controllers for email and password
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final authCubit = GetIt.I.get<AuthManagerCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthManagerCubit, AuthCubitState>(
        bloc: authCubit,
        builder: (context, state) {
          if (state is AuthFailure && context.mounted) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure.message),
                ),
              );
            });
            authCubit.clearFailure();
          }
          return Scaffold(
            // backgroundColor: Colors.transparent,
            body: BackgroundPen(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomPaint(
                      size: Size(208, 243),
                      painter: ModawanLogoPainter(),
                    ),
                    // create two fields for email and password
                    SizedBox(
                      height: 262,
                      child: Column(
                        children: [
                          GlassContainer(
                            child: TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Email',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                    
                          GlassContainer(
                            child: TextField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                hintText: 'Password',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          //forgot password
                          Align(
                            alignment: Alignment.centerLeft,
                    
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // create a button to login
                    GlassContainer(
                      child: SubmitButton(
                          authCubit: authCubit,
                          emailController: emailController,
                          passwordController: passwordController),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    super.key,
    required this.authCubit,
    required this.emailController,
    required this.passwordController,
  });

  final AuthManagerCubit authCubit;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  initState() {
    widget.emailController.addListener(() {
      setState(() {});
    });

    widget.passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  setState(fn) {
    if (mounted) {
      super.setState(() {
        fn();
      });
    }
  }

  bool fieldChecker() {
    return widget.emailController.text.isNotEmpty &&
        widget.passwordController.text.isNotEmpty;
  }

  AuthCubitState get state => widget.authCubit.state;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: state is! AuthLoading && fieldChecker()
          ? () async {
              await widget.authCubit.loginWithPassword(
                  widget.emailController.text, widget.passwordController.text);
              widget.emailController.clear();
              widget.passwordController.clear();
            }
          : null,
      child: state is! AuthLoading
          ? const Text('Login')
          : const SizedBox(
              height: 20, width: 20, child: CircularProgressIndicator()),
    );
  }
}
