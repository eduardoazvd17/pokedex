import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home_page/presentation/controllers/home_page_controller.dart';

import '../../../../core/data/utils/app_theme.dart';
import '../../../../core/presentation/widgets/app_info_widget.dart';
import '../../../../core/presentation/widgets/app_loading_widget.dart';
import '../widgets/pokemon_card_widget.dart';
import '../widgets/pokemon_logo_widget.dart';

class FavoritesPokemonsListView extends GetWidget<HomePageController> {
  const FavoritesPokemonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: controller.error != null ||
                controller.isLoading ||
                controller.favoritesPokemons.isEmpty
            ? Column(
                children: [
                  _headerWidget,
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.error ??
                            (controller.favoritesPokemons.isEmpty
                                ? AppInfoWidget(
                                    message: 'empty-favorites'.i18n())
                                : const AppLoadingWidget()),
                      ],
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  _headerWidget,
                  _favoritesPokemonsListWidget,
                ],
              ),
      ),
    );
  }

  Widget get _headerWidget {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PokemonLogoWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'all-pokemons-list-view-header'.i18n(),
            style: AppTheme.title25w600,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget get _favoritesPokemonsListWidget {
    return Column(
      children: controller.favoritesPokemons
          .map(
            (pokemonModel) => PokemonCardWidget(
              pokemonModel: pokemonModel,
              isFavorite:
                  controller.favoritesOrder.contains(pokemonModel.order),
              toggleFavorite: controller.toggleFavorite,
            ),
          )
          .toList(),
    );
  }
}
