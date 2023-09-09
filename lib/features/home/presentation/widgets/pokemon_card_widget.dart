import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home/data/enums/pokemon_type.dart';
import 'package:pokedex/features/home/presentation/widgets/pokemon_type_tag_widget.dart';

import '../../../../core/data/utils/app_icons.dart';
import '../../../../core/presentation/widgets/app_notification_widget.dart';
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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 382),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            SizedBox(
              height: 132,
              child: Card(
                elevation: 5,
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
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    pokemonModel.name,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/pokeball-overlay.svg',
          fit: BoxFit.fitHeight,
          colorFilter: const ColorFilter.mode(
            Colors.black38,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }

  Widget _favoriteButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        _displayNotification(context, isFavorite);
        toggleFavorite.call(pokemonModel);
      },
      icon: AppIcons.heart(isSelected: isFavorite, size: 35),
    );
  }

  Future<void> _displayNotification(
    BuildContext context,
    bool isFavorite,
  ) async {
    await Get.closeCurrentSnackbar();
    Get.showSnackbar(
      GetSnackBar(
        maxWidth: 207,
        titleText: Container(),
        messageText: isFavorite
            ? AppNotificationWidget(
                icon: AppIcons.heart(),
                text: 'removed-from-favorite'.i18n(),
              )
            : AppNotificationWidget(
                icon: AppIcons.heart(isSelected: true),
                text: 'added-to-favorite'.i18n(),
              ),
        padding: EdgeInsets.zero,
        borderColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.only(
          top: (Get.width > 768) ? 180 : 55,
          left: Get.width - ((Get.width > 768) ? 560 : 270),
        ),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }
}