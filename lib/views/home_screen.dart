import 'package:albums/models/character_model.dart';
import 'package:albums/repos/character_repo.dart';
import 'package:albums/views/widgets/charactor_carousel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CharacterRepository _repository = CharacterRepository();
  late Future<List<CharacterModel>> _charactersInfo;

  @override
  void initState() {
    super.initState();
    _charactersInfo = _repository.fetchCharacters();
  }

  void _refreshData() {
    setState(() {
      _charactersInfo = _repository.fetchCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          return CharactorCarousel(characters: snapshot.data!);
        },
      ),
    );
  }
}
