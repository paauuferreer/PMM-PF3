import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class RickMortyProvider extends ChangeNotifier {
  final String _baseUrl = 'rickandmortyapi.com';

  List<Character> personatgesPrincipals = [];
  List<Character> personatgesPopulars = [];
  Map<int, List<Episode>> episodisPersonatge = {};
  int _paginaActual = 0;

  RickMortyProvider() {
    getPersonatgesPrincipals();
    getPersonatgesPopulars();
  }

  void getPersonatgesPrincipals() async {
    final url = Uri.https(_baseUrl, '/api/character', {'page': '1'});

    final resposta = await http.get(url);
    final characterResponse = CharacterResponse.fromJson(resposta.body);
    personatgesPrincipals = characterResponse.results;
    notifyListeners();
  }

  void getPersonatgesPopulars() async {
    _paginaActual++;
    final url = Uri.https(_baseUrl, '/api/character', {
      'page': '$_paginaActual',
    });

    final resposta = await http.get(url);
    final characterResponse = CharacterResponse.fromJson(resposta.body);
    personatgesPopulars = [...personatgesPopulars, ...characterResponse.results];
    notifyListeners();
  }

  Future<List<Episode>> getEpisodis(Character personatge) async {
    if (episodisPersonatge.containsKey(personatge.id)) {
      return episodisPersonatge[personatge.id]!;
    }

    if (personatge.episode.isEmpty) {
      return [];
    }

    final llistaIds = personatge.episode
        .take(5)
        .map((url) => url.split('/').last)
        .join(',');

    final url = Uri.https(_baseUrl, '/api/episode/$llistaIds');
    final resposta = await http.get(url);

    List<Episode> episodis = [];
    final decoded = json.decode(resposta.body);
    if (decoded is List) {
      episodis = decoded.map((e) => Episode.fromMap(e)).toList();
    } else if (decoded is Map<String, dynamic>) {
      episodis = [Episode.fromMap(decoded)];
    }

    episodisPersonatge[personatge.id] = episodis;
    return episodis;
  }
}
