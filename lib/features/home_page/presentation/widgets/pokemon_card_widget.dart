import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/core/presentation/widgets/app_notification_widget.dart';
import 'package:pokedex/features/home_page/data/enums/pokemon_type.dart';
import 'package:pokedex/features/home_page/presentation/widgets/pokemon_type_tag_widget.dart';

import '../../../../core/data/utils/custom_app_themes.dart';
import '../../../../core/data/utils/custom_app_icons.dart';
import '../../data/models/pokemon_model.dart';

class PokemonCardWidget extends StatelessWidget {
  final PokemonModel pokemonModel;
  final bool isFavorite;
  final void Function(PokemonModel) toggleFavorite;
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
          SizedBox(
            height: 132,
            child: Card(
              elevation: 1,
              color: pokemonModel.types.first.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: -10,
                    child: _pokeballOverlayImage,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: _pokemonContentWidget,
          ),
          Positioned(top: 16, right: 16, child: _favoriteButton(context)),
        ],
      ),
    );
  }

  Widget get _pokemonContentWidget {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 20,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pokemonModel.formattedOrder,
                style: CustomAppThemes.bodySmallTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  pokemonModel.name,
                  style: CustomAppThemes.headerSmallTextStyle,
                ),
              ),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: pokemonModel.types
                    .map((e) => PokemonTypeTagWidget(pokemonType: e))
                    .toList(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: _pokemonImageWidget,
        ),
      ],
    );
  }

  Widget get _pokemonImageWidget {
    return Image.network(
      pokemonModel.imageUrl,
      height: 132,
    );
  }

  Widget get _pokeballOverlayImage {
    return SvgPicture.asset(
      'assets/images/pokeball-overlay.svg',
      fit: BoxFit.fitHeight,
      colorFilter: const ColorFilter.mode(
        Colors.black38,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _favoriteButton(BuildContext context) {
    return IconButton(
      onPressed: () => toggleFavorite.call(pokemonModel),
      icon: CustomAppIcons.heart(isSelected: isFavorite, size: 35),
    );
  }
}
