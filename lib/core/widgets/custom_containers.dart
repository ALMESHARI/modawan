import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:modawan/theme/theme_constants.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;

  const GlassContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 8.0,
        sigmaY: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            boxShadow: [mainBoxShadow],
            border: Border.all(
              color: Colors.white30,
            )),
        child: child,
      ),
    );
  }
}
