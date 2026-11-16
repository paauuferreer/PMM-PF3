import 'package:flutter/material.dart';
import 'package:movies_app/providers/rick_morty_provider.dart';
import 'package:movies_app/search/search_delegate.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rickMortyProvider = Provider.of<RickMortyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
        elevation: 0,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context,
              delegate: CharacterSearchDelegate(),
            ),
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(personatges: rickMortyProvider.personatgesPrincipals),
            CharacterSlider(
              personatges: rickMortyProvider.personatgesPopulars,
              titol: 'Tots els personatges',
              onNextPage: () => rickMortyProvider.getPersonatgesPopulars(),
            ),
          ],
        ),
      ),
    );
  }
}
