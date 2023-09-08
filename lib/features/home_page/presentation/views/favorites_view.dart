import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home_page/presentation/controllers/favorites_view_controller.dart';

import '../../../../core/data/utils/app_theme.dart';
import '../../../../core/presentation/widgets/app_info_widget.dart';
import '../../../../core/presentation/widgets/app_loading_widget.dart';
import '../../../../core/presentation/widgets/responsive_builder.dart';
import '../widgets/pokemon_card_widget.dart';

class FavoritesPokemonsListView extends GetWidget<FavoritesViewController> {
  const FavoritesPokemonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController(
      initialScrollOffset: controller.scrollOffset,
    );

    scrollController.addListener(() {
      controller.scrollOffset = scrollController.offset;
    });

    return Obx(
      () => controller.error != null ||
              controller.isLoading ||
              controller.favorites.isEmpty
          ? Column(
              children: [
                _responsiveHeaderWidget,
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
            )
          : ListView(
              controller: scrollController,
              children: [
                _responsiveHeaderWidget,
                _favoritesPokemonsListWidget,
              ],
            ),
    );
  }

  Widget get _responsiveHeaderWidget {
    final content = Row(
      children: [
        Expanded(
          child: Text(
            'favorites-pokemons-list-view-header'.i18n(),
            style: AppTheme.headerTextStyle,
          ),
        ),
      ],
    );

    return ResponsiveBuilder(
      mobileWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: content,
      ),
      desktopWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 140),
        child: content,
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
