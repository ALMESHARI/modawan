import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:modawan/core/theme/theme_constants.dart';

class BackgroundPen extends StatelessWidget {
  const BackgroundPen({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            // check if theme is dark or light
            gradient: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkBackgroundGradient
                : AppColors.lightBackgroundGradient,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
            child: Container(
              color: Colors.white.withOpacity(0.0),
            )),
        child,
      ],
    );
  }
}
