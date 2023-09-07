import 'package:flutter/material.dart';

import '../../data/enums/pokemon_type.dart';

class PokemonTypeTagWidget extends StatelessWidget {
  final PokemonType pokemonType;
  const PokemonTypeTagWidget({super.key, required this.pokemonType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: pokemonType.color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            pokemonType.icon,
            const SizedBox(width: 2.5),
            Text(
              pokemonType.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
