import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/modules/home/presentation/controllers/favorites_pokemons_list_controller.dart';

import '../../../../core/presentation/widgets/app_info_widget.dart';
import '../../../../core/presentation/widgets/app_loading_widget.dart';
import '../../../../core/presentation/widgets/responsive_builder.dart';
import '../../../../core/presentation/widgets/pokemon_card_widget.dart';

class FavoritesPokemonsListPage
    extends GetWidget<FavoritesPokemonsListController> {
  const FavoritesPokemonsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController(
      initialScrollOffset: controller.scrollOffset,
    );

    scrollController.addListener(() {
      controller.scrollOffset = scrollController.offset;
    });

    return Obx(
      () {
        if (controller.error != null ||
            controller.isLoading ||
            controller.favorites.isEmpty) {
          return Column(
            children: [
              _headerWidget,
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
          final Widget content = ListView(
            controller: scrollController,
            children: [
              _headerWidget,
              _favoritesPokemonsListWidget,
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
      },
    );
  }

  Widget get _headerWidget {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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

  Widget get _favoritesPokemonsListWidget {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      spacing: 5,
      runSpacing: 15,
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
