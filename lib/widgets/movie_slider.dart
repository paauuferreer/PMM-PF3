import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class CharacterSlider extends StatefulWidget {
  final List<Character> personatges;
  final String? titol;
  final Function onNextPage;

  const CharacterSlider({
    super.key,
    required this.personatges,
    this.titol,
    required this.onNextPage,
  });

  @override
  State<CharacterSlider> createState() => _CharacterSliderState();
}

class _CharacterSliderState extends State<CharacterSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titol != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.titol!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.personatges.length,
              itemBuilder: (_, int index) => _CharacterPoster(personatge: widget.personatges[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterPoster extends StatelessWidget {
  final Character personatge;

  const _CharacterPoster({required this.personatge});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: personatge),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(personatge.image),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            personatge.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
