import 'package:flutter/material.dart';

class CardBorder extends StatelessWidget {
  const CardBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange.shade600, width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}
