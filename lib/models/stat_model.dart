class StatModel {
  final String name;
  final String value;

  StatModel({required this.name, required this.value});

  factory StatModel.fromJson(Map<String, dynamic> json) {
    return StatModel(
      name: json["stat_name"] ?? "",
      value: json["stat_value"] ?? "",
    );
  }
}

class CharacterStatModel {
  final String characterClass;
  final List<StatModel> stats;

  CharacterStatModel({required this.characterClass, required this.stats});

  factory CharacterStatModel.fromJson(Map<String, dynamic> json) {
    return CharacterStatModel(
      characterClass: json['character_class'] ?? '',
      stats:
          (json['final_stat'] as List<dynamic>)
              .map((e) => StatModel.fromJson(e))
              .toList(),
    );
  }
}
