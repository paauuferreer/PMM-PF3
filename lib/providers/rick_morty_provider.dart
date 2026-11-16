import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class RickMortyProvider extends ChangeNotifier {
  final String _baseUrl = 'rickandmortyapi.com';

  List<Character> personatgesPrincipals = [];
  List<Character> personatgesPopulars = [];
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
}
