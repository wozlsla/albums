import 'package:albums/models/character_model.dart';
import 'package:albums/models/stat_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  final List<CharacterModel> characters;
  final CharacterStatModel? stat;

  const DetailScreen({
    super.key,
    required this.index,
    required this.characters,
    this.stat,
  });

  @override
  Widget build(BuildContext context) {
    if (stat == null) {
      return Center(
        child: Text("Stat 정보 없음", style: TextStyle(color: Colors.white)),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.64,
      child: _buildStatView(stat!),
    );
  }

  Widget _buildStatView(CharacterStatModel stat) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: ListView(
        children: [
          Center(
            child: Text(
              "직업: ${stat.characterClass}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...stat.stats.map(
            (s) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      s.name,
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 19,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      s.value,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
