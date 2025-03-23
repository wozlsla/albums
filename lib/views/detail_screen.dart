import 'package:albums/models/character_model.dart';
import 'package:albums/models/stat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetailScreen extends StatelessWidget {
  static const Set<String> importantStats = {
    "보스 몬스터 데미지",
    "방어율 무시",
    "최종 데미지",
    "크리티컬 확률",
    "크리티컬 데미지",
  };

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
            child: AnimatedOpacity(
              opacity: 0.9,
              duration: 900.ms,
              child: Text(
                "직업: ${stat.characterClass}",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                      blurRadius: 30,
                      color: Colors.deepOrange.withValues(alpha: 0.8),
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ).animate().flipH(duration: 1500.ms),
          ),
          const SizedBox(height: 20),
          ...stat.stats.map((s) {
            final isImportant = importantStats.contains(s.name);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      s.name,
                      style: TextStyle(
                        color:
                            isImportant
                                ? Colors.orange.shade600.withValues(alpha: 0.7)
                                : Colors.white60,
                        fontSize: 19,
                        fontWeight: isImportant ? FontWeight.w600 : null,
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
            );
          }),
        ],
      ),
    );
  }
}
