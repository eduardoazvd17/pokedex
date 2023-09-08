import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home_page/presentation/controllers/home_page_controller.dart';
import 'package:pokedex/features/home_page/presentation/widgets/pokemon_card_widget.dart';

import '../../../../core/data/utils/custom_app_themes.dart';
import '../../../../core/presentation/widgets/app_loading_widget.dart';
import '../widgets/pokemon_logo_widget.dart';

class AllPokemonsListView extends GetWidget<HomePageController> {
  const AllPokemonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController(
      initialScrollOffset: controller.allPokemonsListScrollOffset,
    );
    scrollController.addListener(() {
      controller.allPokemonsListScrollOffset = scrollController.offset;
    });

    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
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
            : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                          (scrollInfo.metrics.maxScrollExtent - 50) &&
                      !controller.isLoadingMore) {
                    controller.loadPokemons();
                  }
                  return true;
                },
                child: ListView(
                  controller: scrollController,
                  children: [
                    _headerWidget,
                    _pokemonsListWidget,
                    if (controller.isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: AppLoadingWidget(),
                      ),
                  ],
                ),
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
            style: CustomAppThemes.headerTextStyle,
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
              isFavorite: controller.favoritesPokemons.contains(pokemonModel),
              toggleFavorite: controller.toggleFavorite,
            ),
          )
          .toList(),
    );
  }
}
