import 'package:albums/models/character_model.dart';
import 'package:flutter/material.dart';

class CharactorCarousel extends StatefulWidget {
  final List<CharacterModel> characters;

  const CharactorCarousel({super.key, required this.characters});

  @override
  State<CharactorCarousel> createState() => _CharactorCarouselState();
}

class _CharactorCarouselState extends State<CharactorCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage; // 현재 page 저장
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page == null) return;
      _scroll.value = _pageController.page!;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: _onPageChanged,
      controller: _pageController,
      itemCount: widget.characters.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final character = widget.characters[index];

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: character.characterName,
              child: Image.network(
                character.characterImageUrl,
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 100, color: Colors.red);
                },
              ),
            ),
            Text(
              character.characterName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(character.characterClass, style: TextStyle(fontSize: 16)),
            Text(character.worldName, style: TextStyle(fontSize: 16)),
            Text("${character.characterLevel}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
