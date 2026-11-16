import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Character> personatges;

  const CardSwiper({super.key, required this.personatges});

  @override
  Widget build(BuildContext context) {
    final mida = MediaQuery.of(context).size;

    if (personatges.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: mida.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: mida.height * 0.5,
      child: Swiper(
        itemCount: personatges.length,
        layout: SwiperLayout.STACK,
        itemWidth: mida.width * 0.6,
        itemHeight: mida.height * 0.4,
        itemBuilder: (BuildContext context, int index) {
          final personatge = personatges[index];

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: personatge),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(personatge.image),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
