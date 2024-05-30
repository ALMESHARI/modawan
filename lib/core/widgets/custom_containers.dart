import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:modawan/theme/theme_constants.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double radius;
  final double? height;

  const GlassContainer({super.key, required this.child, this.radius = 10, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.white.withOpacity(0.1),
          boxShadow: [mainBoxShadow],
          border: Border.all(
            color: Color.fromARGB(77, 198, 198, 198).withOpacity(0.2),
          )),
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          // blendMode: BlendMode.,
          filter: ImageFilter.blur(
            sigmaX: 8.0,
            sigmaY: 8.0,
          ),
          child: child,
        ),
      ),
    );
  }
}
