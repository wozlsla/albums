import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BackgroundSwitcher extends StatelessWidget {
  final int currentPage;

  const BackgroundSwitcher({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 500.ms,
      child: Container(
        key: ValueKey(currentPage),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/covers/1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.black.withValues(alpha: 0.6)),
        ),
      ),
    );
  }
}
