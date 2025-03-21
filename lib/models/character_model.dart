class CharacterModel {
  final String characterName;
  final String worldName;
  final String characterClass;
  final int characterLevel;
  final String characterImageUrl;

  CharacterModel({
    required this.characterName,
    required this.worldName,
    required this.characterClass,
    required this.characterLevel,
    required this.characterImageUrl,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      characterName: json["character_name"] ?? "Unknown",
      worldName: json["world_name"] ?? "Unknown",
      characterClass: json["character_class"] ?? "Unknown",
      characterLevel: json["character_level"] ?? 0,
      characterImageUrl:
          json["character_image"]?.isNotEmpty == true
              ? json["character_image"]
              : "https://via.placeholder.com/150", // 기본 이미지
    );
  }
}
