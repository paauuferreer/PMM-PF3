import 'dart:convert';
import 'package:movies_app/models/character.dart';

class CharacterResponse {
  CharacterResponse({
    required this.info,
    required this.results,
  });

  Info info;
  List<Character> results;

  factory CharacterResponse.fromJson(String str) => CharacterResponse.fromMap(json.decode(str));

  factory CharacterResponse.fromMap(Map<String, dynamic> json) => CharacterResponse(
    info: Info.fromMap(json["info"]),
    results: List<Character>.from(json["results"].map((x) => Character.fromMap(x))),
  );
}

class Info {
  Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  int count;
  int pages;
  String? next;
  String? prev;

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  factory Info.fromMap(Map<String, dynamic> json) => Info(
    count: json["count"],
    pages: json["pages"],
    next: json["next"],
    prev: json["prev"],
  );
}
