import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BackgroundSwitcher extends StatelessWidget {
  final int index;

  const BackgroundSwitcher({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 500.ms,
      child: SizedBox(
        key: ValueKey(index),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -0.8),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Image.asset("assets/covers/${index + 1}.jpg"),
              ),
              /* Image.asset(
                "assets/covers/${index + 1}.jpg",
                fit: BoxFit.contain,
                // alignment: Alignment.topCenter,
              ), */
            ),
            /* BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ), // 1번 blur 튐 */
            Container(color: Colors.black.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }
}
