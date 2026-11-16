import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/rick_morty_provider.dart';
import 'package:provider/provider.dart';

class CharacterSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Cercar personatge';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _construirResultats(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(Icons.person_search_outlined, color: Colors.black26, size: 120),
      );
    }
    return _construirResultats(context);
  }

  Widget _construirResultats(BuildContext context) {
    final rickMortyProvider = Provider.of<RickMortyProvider>(context, listen: false);

    return FutureBuilder(
      future: rickMortyProvider.cercarPersonatges(query),
      builder: (BuildContext context, AsyncSnapshot<List<Character>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final personatges = snapshot.data!;

        if (personatges.isEmpty) {
          return const Center(
            child: Text('No s\'ha trobat cap personatge.'),
          );
        }

        return ListView.builder(
          itemCount: personatges.length,
          itemBuilder: (BuildContext context, int index) {
            final personatge = personatges[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(personatge.image),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(personatge.name),
              subtitle: Text('${personatge.species} - ${personatge.status}'),
              onTap: () {
                Navigator.pushNamed(context, 'details', arguments: personatge);
              },
            );
          },
        );
      },
    );
  }
}
