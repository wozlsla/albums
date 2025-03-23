import 'package:albums/models/character_model.dart';
import 'package:albums/views/widgets/card_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                    IconButton(
                      onPressed: toggleDetail,
                      icon: FaIcon(FontAwesomeIcons.chevronUp),
                    ),
                    Stack(
                      children: [
                        CardBorder(),
                        Column(
                          children: [
                            Image.network(
                              character.characterImageUrl,
                              height: 150,
                              scale: 0.5,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.error,
                                  size: 100,
                                  color: Colors.red,
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      character.characterName,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      character.characterClass,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                // Text(
                                //   character.worldName,
                                //   style: TextStyle(fontSize: 16),
                                // ),
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
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
