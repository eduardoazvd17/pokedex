import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/modules/home/presentation/controllers/favorites_pokemons_list_controller.dart';

import '../../../../core/presentation/widgets/app_info_widget.dart';
import '../../../../core/presentation/widgets/app_loading_widget.dart';
import '../../../../core/presentation/widgets/responsive_builder.dart';
import '../../../../core/presentation/widgets/pokemon_card_widget.dart';

class FavoritesPokemonsListPage extends StatelessWidget {
  final FavoritesPokemonsListController controller;
  const FavoritesPokemonsListPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final Widget content = Column(
      children: [
        _headerWidget,
        Expanded(child: _pageContent),
      ],
    );

    return ResponsiveBuilder(
      mobileWidget: Padding(
        padding: const EdgeInsets.only(top: 15, left: 28, right: 28),
        child: content,
      ),
      desktopWidget: Padding(
        padding: const EdgeInsets.only(
          top: 35,
          left: 124,
          right: 124,
          bottom: 10,
        ),
        child: content,
      ),
    );
  }

  Widget get _headerWidget {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'favorites-pokemons-list-view-header'.i18n(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _pageContent {
    return Obx(() {
      if (controller.error != null ||
          controller.isLoading ||
          controller.favorites.isEmpty) {
        return Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.error ??
                      (controller.favorites.isEmpty
                          ? AppInfoWidget(
                              message: 'empty-favorites'.i18n(),
                            )
                          : const AppLoadingWidget()),
                ],
              ),
            ),
          ],
        );
      } else {
        final scrollController = ScrollController(
          initialScrollOffset: controller.scrollOffset,
        );

        scrollController.addListener(() {
          controller.scrollOffset = scrollController.offset;
        });

        return ListView(
          controller: scrollController,
          children: [
            _favoritesPokemonsListWidget,
          ],
        );
      }
    });
  }

  Widget get _favoritesPokemonsListWidget {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      spacing: 5,
      runSpacing: 5,
      children: controller.favorites
          .map(
            (pokemonModel) => PokemonCardWidget(
              pokemonModel: pokemonModel,
              isFavorite: controller.favorites.contains(pokemonModel),
              toggleFavorite: controller.toggleFavorite,
            ),
          )
          .toList(),
    );
  }
}
