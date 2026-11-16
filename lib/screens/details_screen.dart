import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Character personatge = ModalRoute.of(context)!.settings.arguments as Character;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(personatge: personatge),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(personatge: personatge),
                _CharacterInfo(personatge: personatge),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Episodis destacats',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                EpisodeCards(personatge: personatge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Character personatge;

  const _CustomAppBar({required this.personatge});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.teal,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black38,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text(
            personatge.name,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(personatge.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Character personatge;

  const _PosterAndTitle({required this.personatge});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(personatge.image),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personatge.name,
                  style: textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                Text(
                  '${personatge.species} (${personatge.gender})',
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 14,
                      color: personatge.status == 'Alive'
                          ? Colors.green
                          : personatge.status == 'Dead'
                              ? Colors.red
                              : Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(personatge.status, style: textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterInfo extends StatelessWidget {
  final Character personatge;

  const _CharacterInfo({required this.personatge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Origen: ${personatge.origin.name}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          Text(
            'Ubicació actual: ${personatge.location.name}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (personatge.type.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              'Tipus: ${personatge.type}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ],
      ),
    );
  }
}
