import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/rick_morty_provider.dart';
import 'package:provider/provider.dart';

class EpisodeCards extends StatelessWidget {
  final Character personatge;

  const EpisodeCards({super.key, required this.personatge});

  @override
  Widget build(BuildContext context) {
    final rickMortyProvider = Provider.of<RickMortyProvider>(context, listen: false);

    return FutureBuilder(
      future: rickMortyProvider.getEpisodis(personatge),
      builder: (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 120,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final episodis = snapshot.data!;

        if (episodis.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('No hi ha episodis disponibles.'),
          );
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 120,
          child: ListView.builder(
            itemCount: episodis.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => _EpisodeCard(episodi: episodis[index]),
          ),
        );
      },
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  final Episode episodi;

  const _EpisodeCard({required this.episodi});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10),
      width: 140,
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.tv, color: Colors.teal, size: 28),
          const SizedBox(height: 5),
          Text(
            episodi.episode,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            episodi.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
