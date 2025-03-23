import 'package:albums/models/character_model.dart';
import 'package:albums/views/widgets/card_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class CardView extends StatelessWidget {
  final List<CharacterModel> characters;
  final PageController pageController;
  final bool onDetail;
  final ValueListenable<double> scroll;
  final void Function(int) onPageChanged;
  final VoidCallback toggleDetail;

  const CardView({
    super.key,
    required this.characters,
    required this.pageController,
    required this.onDetail,
    required this.scroll,
    required this.onPageChanged,
    required this.toggleDetail,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: onPageChanged,
      controller: pageController,
      itemCount: characters.length,
      scrollDirection: Axis.horizontal,
      physics:
          onDetail ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final character = characters[index];

        return ValueListenableBuilder(
          valueListenable: scroll,
          builder: (context, scroll, child) {
            final difference = (scroll - index).abs();
            final scale = 1 - (difference * 0.16);

            return GestureDetector(
              onVerticalDragEnd: (_) => toggleDetail(),
              child: Transform.scale(
                scale: scale,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    IconButton(
                      onPressed: toggleDetail,
                      icon:
                          onDetail
                              ? FaIcon(FontAwesomeIcons.chevronDown)
                              : FaIcon(FontAwesomeIcons.chevronUp),
                    ),
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        CardBorder(),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Text(
                            character.worldName,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Positioned(
                          left: 80,
                          top: 20,
                          child: Lottie.asset(
                            "assets/lottie/flare.json",
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            // repeat: true,
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16, // 오른쪽 제약 - Row가 전체 너비 사용하게 함
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    character.characterName,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    character.characterClass == "블래스터"
                                        ? "린"
                                        : character.characterClass,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${character.characterLevel} ",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    "Level ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
