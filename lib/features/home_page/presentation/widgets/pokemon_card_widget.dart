import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/features/home_page/data/enums/pokemon_type.dart';
import 'package:pokedex/features/home_page/presentation/widgets/pokemon_type_tag_widget.dart';

import '../../../../core/data/utils/app_icons.dart';
import '../../../../core/data/utils/app_theme.dart';
import '../../data/models/pokemon_model.dart';

class PokemonCardWidget extends StatelessWidget {
  final PokemonModel pokemonModel;
  final bool isFavorite;
  final void Function(int) toggleFavorite;
  const PokemonCardWidget({
    super.key,
    required this.pokemonModel,
    required this.isFavorite,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Stack(
        children: [
          Card(
            elevation: 1,
            color: pokemonModel.types.first.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: _content,
          ),
          Positioned(top: 10, right: 10, child: _favoriteButton),
        ],
      ),
    );
  }

  Widget get _content {
    return Stack(
      children: [
        Positioned(right: 0, top: 0, bottom: 0, child: _pokeballOverlayImage),
        Row(
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
        ),
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
    );
  }

  Widget get _pokeballOverlayImage {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: SvgPicture.asset(
        'assets/images/pokeball-overlay.svg',
        colorFilter: const ColorFilter.mode(
          Colors.black38,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget get _favoriteButton {
    return IconButton(
      onPressed: () => toggleFavorite.call(pokemonModel.order),
      icon: AppIcons.heart(isSelected: isFavorite),
    );
  }
}
