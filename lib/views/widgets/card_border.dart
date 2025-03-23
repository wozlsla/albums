import 'package:flutter/material.dart';

class CardBorder extends StatelessWidget {
  const CardBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange.shade600, width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13.5),
        child: Container(color: Colors.black.withValues(alpha: 0.6)),
      ),
    );
  }
}
