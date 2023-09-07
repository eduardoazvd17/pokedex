import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/home_page/presentation/widgets/pokemon_type_tag_widget.dart';

import '../../../../core/data/utils/app_theme.dart';
import '../../data/models/pokemon_model.dart';

class PokemonCardWidget extends StatelessWidget {
  final PokemonModel pokemonModel;
  const PokemonCardWidget({super.key, required this.pokemonModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Stack(
        children: [
          Card(
            elevation: 1,
            color: Colors.blue[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: _content,
          ),
          Positioned(right: 0, top: 0, bottom: 0, child: _pokeballOverlayImage),
          Positioned(top: 10, right: 10, child: _favoriteButton),
        ],
      ),
    );
  }

  Widget get _content {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pokemonModel.formattedOrder),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    pokemonModel.name,
                    style: AppTheme.title25w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _pokemonTypeTagsWidgets,
                ),
              ],
            ),
          ),
        ),
        _pokemonImageWidget,
      ],
    );
  }

  Widget get _pokemonTypeTagsWidgets {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: pokemonModel.types
          .map((e) => PokemonTypeTagWidget(pokemonType: e))
          .toList(),
    );
  }

  Widget get _pokemonImageWidget {
    return Image.network(
      pokemonModel.imageUrl,
      height: 150,
      width: 120,
    );
  }

  Widget get _pokeballOverlayImage {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset(
        'assets/images/pokeball-overlay.png',
        color: Colors.black12,
        filterQuality: FilterQuality.low,
        opacity: const AlwaysStoppedAnimation(0.3),
      ),
    );
  }

  Widget get _favoriteButton {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        CupertinoIcons.heart,
        color: Colors.black,
        size: 40,
      ),
    );
  }
}
