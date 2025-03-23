import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CharacterView extends StatelessWidget {
  final List<String> imageUrls;
  final PageController characterController;

  const CharacterView({
    super.key,
    required this.imageUrls,
    required this.characterController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(), // 사용자 스크롤 차단
        controller: characterController,
        itemCount: imageUrls.length,
        itemBuilder:
            (context, index) => Image.network(
                  imageUrls[index],
                  height: 150,
                  scale: 0.45,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: 100, color: Colors.red);
                  },
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .moveY(
                  begin: -3,
                  end: 3,
                  duration: 1.seconds,
                  curve: Curves.easeInOut,
                ),
      ),
    );
  }
}
