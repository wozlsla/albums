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
      child: Transform.translate(
        offset: Offset(0, -180),
        child: Container(
          key: ValueKey(currentPage),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/covers/${currentPage + 1}.jpg"),
              // image: AssetImage("assets/covers/${currentPage + 1}.webp"),
              fit: BoxFit.contain,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.black.withValues(alpha: 0.5)),
          ),
        ),
      ),
    );
  }
}
