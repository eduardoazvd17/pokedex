import 'package:flutter/material.dart';

class PokemonLogoWidget extends StatelessWidget {
  const PokemonLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: Image.asset(
        'assets/images/pokemon-logo.png',
        width: 149,
        height: 60,
      ),
    );
  }
}
