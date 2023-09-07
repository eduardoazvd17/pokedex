import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home_page/presentation/widgets/pokemon_card_widget.dart';

import '../../../../core/data/utils/app_theme.dart';

class AllPokemonsListView extends StatelessWidget {
  const AllPokemonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 4,
            ),
            child: Image.asset(
              'assets/images/pokemon-logo.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'all-pokemons-list-view-header'.i18n(),
              style: AppTheme.title25w600,
            ),
          ),
          PokemonCardWidget(),
          PokemonCardWidget(),
          PokemonCardWidget(),
          PokemonCardWidget(),
          PokemonCardWidget(),
        ],
      ),
    );
  }
}
