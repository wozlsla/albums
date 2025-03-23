import 'package:albums/models/character_model.dart';
import 'package:albums/models/stat_model.dart';
import 'package:albums/repos/character_repo.dart';
import 'package:albums/views/detail_screen.dart';
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
  final Map<String, CharacterStatModel> _statCache = {};

  int currentPage = 0;
  bool onDetail = false;

  final PageController pageController = PageController(viewportFraction: 0.8);
  final PageController characterController = PageController(
    viewportFraction: 0.9,
  );
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _charactersInfo = _repository.fetchCharacters();

    pageController.addListener(() {
      if (pageController.page == null) return;
      _scroll.value = pageController.page!;

      /* 너무 미세함 
        characterController.animateTo(
        pageController.position.pixels,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      ); */

      final int targetPage = pageController.page!.round();

      if (characterController.hasClients &&
          characterController.page?.round() != targetPage) {
        characterController.animateToPage(
          targetPage,
          duration: 200.ms,
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _refreshData() {
    setState(() {
      _charactersInfo = _repository.fetchCharacters();
    });
  }

  Future<void> _loadStat(String ocid) async {
    if (_statCache.containsKey(ocid)) return; // 이미 있으면 패스

    try {
      final stat = await _repository.fetchCharacterStat(ocid);
      setState(() {
        _statCache[ocid] = stat;
      });
    } catch (e) {
      print("[Stat 요청 실패] $e");
    }
  }

  void _handleToggleDetail(List<CharacterModel> characters) {
    final ocid = characters[currentPage].ocid;
    _loadStat(ocid); // stat 로딩 트리거
    setState(() => onDetail = !onDetail);
  }

  @override
  void dispose() {
    pageController.dispose();
    characterController.dispose();
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
              BackgroundSwitcher(index: currentPage),
              CardView(
                pageController: pageController,
                onDetail: onDetail,
                scroll: _scroll,
                onPageChanged: (value) => setState(() => currentPage = value),
                toggleDetail: () => _handleToggleDetail(snapshot.data!),
                characters: snapshot.data!,
              ).animateY(
                onDetail: onDetail,
                begin: 0,
                end: 0.34,
                duration: 500,
              ),
              Center(
                child: CharacterView(
                  characterController: characterController,
                  imageUrls:
                      snapshot.data!.map((e) => e.characterImageUrl).toList(),
                ).animateY(
                  onDetail: onDetail,
                  begin: 0,
                  end: 1.4,
                  duration: 500,
                ),
              ),
              DetailScreen(
                index: currentPage,
                characters: snapshot.data!,
                stat: _statCache[snapshot.data![currentPage].ocid],
              ).animateY(onDetail: onDetail, begin: -1, end: 0),
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
      // curve: Curves.easeInCubic,
    );
  }
}
