import 'package:flutter/material.dart';

class CardBorder extends StatelessWidget {
  const CardBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orange.shade600.withValues(alpha: 0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13.5),
        child: Container(color: Colors.black.withValues(alpha: 0.6)),
      ),
    );
  }
}
