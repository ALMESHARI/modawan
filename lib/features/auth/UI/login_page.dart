import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/core/components/widgets/background.dart';
import 'package:modawan/core/components/widgets/custom_containers.dart';
import 'package:modawan/core/components/widgets/modawan_logo.dart';
import 'package:modawan/features/auth/cubit/auth_manager_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:modawan/core/theme/theme_constants.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final authCubit = GetIt.I.get<AuthManagerCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<AuthManagerCubit, AuthManagerCubitState>(
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
              authCubit.clearState();
            } else if (state is AuthOTPSent && context.mounted) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('OTP sent to your email'),
                  ),
                );
              });
            }

            final isDark =
                Theme.of(context).brightness == Brightness.dark ? true : false;
            return BackgroundPen(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 500,
                  padding: const EdgeInsets.symmetric(
                      vertical: 80.0, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // CustomPaint(
                      //   size: const Size(208, 243),
                      //   painter: ModawanLogoPainter(
                      //       isDark ? AppColors.whiteblue : AppColors.darkblue),
                      // ),
                      ModawanLogo(
                        width: 200,
                        color:
                            isDark ? AppColors.whiteblue : AppColors.darkblue,
                        labeled: true,
                      ),
                      Column(
                        children: [
                          GlassContainer(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: TextField(
                                    // disable when loading
                                    enabled: state is! AuthLoading &&
                                        state is! AuthOTPSent,
                                    // put value to be the same email when otp is sent
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: 'Email',
                                    ),
                                  ),
                                ),
                                state is AuthOTPSent
                                    ? IconButton(
                                        onPressed: () {
                                          authCubit.clearState();
                                          emailController.clear();
                                        },
                                        icon: const Icon(Icons.edit),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await authCubit.loginWithPassword(
                                    'test1@test.com', 'test1234');
                              },
                              child: const Text('for test')),
                          () {
                            if (state is AuthOTPSent) {
                              return GlassContainer(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0, vertical: 12.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.verified,
                                        color: AppColors.highlighttextcolor,
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          'We have sent a verfication link to your email',
                                          style: AppTextStyles.buttontextstyle
                                              .copyWith(
                                                  height: 1.2,
                                                  color: AppColors
                                                      .highlighttextcolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          }()
                        ],
                      ),
                      Column(
                        children: [
                          // create a button to login
                          GlassContainer(
                            child: SubmitButton(
                              authCubit: authCubit,
                              emailController: emailController,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GoogleAuthButton(
                            authCubit: authCubit,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key, required this.authCubit});
  final AuthManagerCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthManagerCubit, AuthManagerCubitState>(
      bloc: authCubit,
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            if (state is! AuthLoading) {
              await authCubit.googleSignIn(kIsWeb);
            }
          },
          child: GlassContainer(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 27,
                        width: 27,
                        child: Image.asset('assets/images/google_logo.png')),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Login with Google',
                      style: AppTextStyles.buttontextstyle,
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    super.key,
    required this.authCubit,
    required this.emailController,
  });

  final AuthManagerCubit authCubit;
  final TextEditingController emailController;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  void initState() {
    super.initState();
    widget.emailController.addListener(_emailChanged);
  }

  void _emailChanged() {
    setState(() {
      // Any state updates should go here if needed
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    widget.emailController.removeListener(_emailChanged);
    super.dispose();
  }

  bool fieldChecker() {
    return widget.emailController.text.trim().isNotEmpty;
  }

  AuthManagerCubitState get state => widget.authCubit.state;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: state is! AuthLoading && fieldChecker()
          ? () async {
              await widget.authCubit
                  .loginWithEmailOTP(widget.emailController.text);
              // widget.authCubit.emit(AuthOTPSent(widget.emailController.text));
            }
          : null,
      child: state is! AuthLoading
          ? const Text('Login')
          : const SizedBox(
              height: 20, width: 20, child: CircularProgressIndicator()),
    );
  }
}
