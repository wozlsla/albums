import 'package:flutter/material.dart';

class CharacterView extends StatelessWidget {
  final List<String> imageUrls;

  const CharacterView({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder:
            (context, index) => Image.network(
              imageUrls[index],
              height: 150,
              scale: 0.5,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 100, color: Colors.red);
              },
            ),
      ),
    );
  }
}
