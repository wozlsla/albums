import 'dart:convert';

import 'package:albums/models/character_model.dart';
import 'package:albums/models/stat_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CharacterRepository {
  final String _apiKey = dotenv.env["API_KEY"] ?? "";

  // OCID 조회할 닉네임
  final List<String> characterNames = [
    "뿌꾸리꼬순내",
    "새짐니",
    "꾸꾸리꼬릿내",
    "깅현", // o
    "알갱모르갱", // o
    // "꾹꾸리꼬신내",
  ];

  // OCID(캐릭터 식별자) 조회
  Future<String> _fetchOcid(String characterName) async {
    // final encodedName = Uri.encodeComponent(characterName); // 한글 인코딩
    final url = Uri.https("open.api.nexon.com", "/maplestory/v1/id", {
      "character_name": characterName,
    });
    // print("요청 URL: $url");

    final response = await http.get(
      url,
      headers: {"x-nxopen-api-key": _apiKey},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print("OCID: ${data["ocid"]}");
      return data["ocid"];
    } else {
      print("OCID 조회 실패: ${response.statusCode}, 응답 내용: ${response.body}");
      throw Exception("OCID 조회 실패: ${response.statusCode}");
    }
  }

  // Character 상세 정보 조회
  Future<CharacterModel> _fetchCharacterData(String ocid) async {
    final url = Uri.https(
      "open.api.nexon.com",
      "/maplestory/v1/character/basic",
      {"ocid": ocid},
    );

    int retryCount = 0;
    while (retryCount < 3) {
      final response = await http.get(
        url,
        headers: {"x-nxopen-api-key": _apiKey},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CharacterModel.fromJson(data, ocid);
      } else if (response.statusCode == 429) {
        print("Too much requests (429), Retry...");
        retryCount++;
        await Future.delayed(Duration(seconds: 2 * retryCount));
      } else {
        throw Exception("캐릭터 조회 실패: ${response.statusCode}");
      }
    }
    throw Exception("캐릭터 조회 3회 실패");
  }

  // Characters 정보
  Future<List<CharacterModel>> fetchCharacters() async {
    List<CharacterModel> characters = [];

    for (String name in characterNames) {
      try {
        print("[$name] OCID 요청 중...");
        String ocid = await _fetchOcid(name);
        print("[$name] OCID: $ocid"); // OCID 정상 출력 확인

        await Future.delayed(Duration(milliseconds: 500));
        CharacterModel character = await _fetchCharacterData(ocid);
        characters.add(character);

        await Future.delayed(Duration(milliseconds: 500));
      } catch (e) {
        print("[$name] 정보 불러오기 실패: $e");
      }
    }
    return characters;
  }

  // Stat 정보
  Future<CharacterStatModel> fetchCharacterStat(String ocid) async {
    final url = Uri.https(
      "open.api.nexon.com",
      "/maplestory/v1/character/stat",
      {"ocid": ocid},
    );

    // print("[Stat 요청] ocid: $ocid");

    final response = await http.get(
      url,
      headers: {"x-nxopen-api-key": _apiKey},
    );

    print("[Stat 응답] status: ${response.statusCode}");
    // print("[Stat 응답] body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CharacterStatModel.fromJson(data);
    } else {
      throw Exception("Stat 정보 조회 실패 (${response.statusCode})");
    }
  }

  /* // 날짜 포맷 - 생랴: 최근
  String getToday() {
    final now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}";
  } */
}
