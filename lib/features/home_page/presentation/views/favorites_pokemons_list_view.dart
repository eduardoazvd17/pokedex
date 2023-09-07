import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class FavoritesPokemonsListView extends StatelessWidget {
  const FavoritesPokemonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'favorites-pokemons-list-view-header'.i18n(),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
