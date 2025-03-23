import 'package:albums/models/character_model.dart';
import 'package:albums/models/stat_model.dart';
import 'package:albums/repos/character_repo.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final List<CharacterModel> characters;

  const DetailScreen({
    super.key,
    required this.index,
    required this.characters,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final CharacterRepository _repository = CharacterRepository();
  Future<CharacterStatModel>? _statItem;

  @override
  void initState() {
    super.initState();

    final character = widget.characters[widget.index];
    final ocid = character.ocid;

    _statItem = _repository.fetchCharacterStat(ocid);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: _statItem,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Stat 정보를 불러오는 데 실패했습니다.\n${snapshot.error}"),
              );
            }

            final stat = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "직업: ${stat.characterClass}",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  ...stat.stats.map(
                    (s) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              s.name,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              s.value,
                              // textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
