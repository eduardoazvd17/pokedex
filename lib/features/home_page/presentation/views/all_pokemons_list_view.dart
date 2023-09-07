import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home_page/presentation/controllers/home_page_controller.dart';
import 'package:pokedex/features/home_page/presentation/widgets/pokemon_card_widget.dart';

import '../../../../core/data/utils/app_theme.dart';
import '../../../../core/presentation/widgets/app_loading_widget.dart';
import '../widgets/pokemon_logo_widget.dart';

class AllPokemonsListView extends GetWidget<HomePageController> {
  const AllPokemonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: controller.error != null ||
                controller.isLoading ||
                controller.allPokemons.isEmpty
            ? Column(
                children: [
                  _headerWidget,
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.error ?? const AppLoadingWidget(),
                      ],
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  _headerWidget,
                  _pokemonsListWidget,
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

  Widget get _pokemonsListWidget {
    return Column(
      children: controller.allPokemons
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
