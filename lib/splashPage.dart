import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/dependency_container.dart';
import 'package:modawan/features/auth/cubit/auth_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

@override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
