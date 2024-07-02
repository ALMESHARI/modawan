import 'package:flutter/material.dart';
import 'package:modawan/core/components/widgets/modawan_logo.dart';
import 'package:modawan/core/theme/theme_constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

@override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark ? true : false;
    return Scaffold(
      body: Center(child: ModawanLogo(width: 200, color: isDark ? AppColors.whiteblue : AppColors.darkblue)),
    );
  }
}
