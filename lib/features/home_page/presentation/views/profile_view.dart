import 'package:flutter/material.dart';

import '../widgets/pokemon_logo_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView(
        children: [
          const PokemonLogoWidget(),
          Container(
            height: 124,
            width: 124,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
          ),
        ],
      ),
    );
  }
}
