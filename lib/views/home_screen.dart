import 'package:albums/models/character_model.dart';
import 'package:albums/repos/character_repo.dart';
import 'package:albums/views/widgets/background_switcher.dart';
import 'package:albums/views/widgets/card_view.dart';
import 'package:albums/views/widgets/character_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CharacterRepository _repository = CharacterRepository();
  late Future<List<CharacterModel>> _charactersInfo;

  int currentPage = 0;
  bool onDetail = false;

  final PageController pageController = PageController(viewportFraction: 0.8);
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _charactersInfo = _repository.fetchCharacters();

    pageController.addListener(() {
      if (pageController.page == null) return;
      _scroll.value = pageController.page!;
    });
  }

  void _refreshData() {
    setState(() {
      _charactersInfo = _repository.fetchCharacters();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<CharacterModel>>(
        future: _charactersInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error: ${snapshot.error}",
                    style: TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(onPressed: _refreshData, child: Text("Retry")),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Data"));
          }

          return Stack(
            children: [
              BackgroundSwitcher(currentPage: currentPage),
              CardView(
                pageController: pageController,
                onDetail: onDetail,
                scroll: _scroll,
                onPageChanged: (value) => setState(() => currentPage = value),
                toggleDetail: () => setState(() => onDetail = !onDetail),
                characters: snapshot.data!,
              ).animateY(
                onDetail: onDetail,
                begin: 0,
                end: 0.23,
                duration: 500,
              ),
              Center(
                child: CharacterView(
                  imageUrls:
                      snapshot.data!.map((e) => e.characterImageUrl).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

extension _AnimateY on Widget {
  Animate animateY({
    required bool onDetail,
    required double begin,
    required double end,
    int duration = 500,
  }) {
    return animate(target: onDetail ? 1 : 0).slideY(
      begin: begin,
      end: end,
      duration: duration.milliseconds,
      curve: Curves.easeInCubic,
    );
  }
}
