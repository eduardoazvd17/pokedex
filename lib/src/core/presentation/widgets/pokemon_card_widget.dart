import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/core/data/enums/pokemon_type.dart';
import 'package:pokedex/src/core/presentation/widgets/pokemon_type_tag_widget.dart';
import 'package:pokedex/src/modules/home/presentation/controllers/details_controller.dart';
import 'package:pokedex/src/modules/home/presentation/controllers/home_controller.dart';

import '../../data/utils/app_icons.dart';
import '../../data/models/pokemon_model.dart';
import 'app_notification_widget.dart';

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
    return GestureDetector(
      onTap: () {
        if (Get.isRegistered<DetailsController>()) {
          Get.find<DetailsController>().open(context, pokemonModel);
        }
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 382),
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
            Positioned(top: 16, right: 16, child: _favoriteButton),
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
                  ).animate().slideX().fade(),
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
    ).animate().flipH();
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

  Widget get _favoriteButton {
    return IconButton(
      onPressed: () {
        _displayNotification(isFavorite);
        toggleFavorite.call(pokemonModel);
      },
      icon: AppIcons.heart(isSelected: isFavorite, size: 35)
          .animate()
          .slideY()
          .fade(),
    );
  }

  Future<void> _displayNotification(bool isFavorite) async {
    if (Get.isRegistered<HomeController>()) {
      final AppNotificationWidget notification = isFavorite
          ? AppNotificationWidget(
              icon: AppIcons.heart(),
              text: 'removed-from-favorite'.i18n(),
            )
          : AppNotificationWidget(
              icon: AppIcons.heart(isSelected: true),
              text: 'added-to-favorite'.i18n(),
            );
      Get.find<HomeController>().showNotification(notification);
    }
  }
}
