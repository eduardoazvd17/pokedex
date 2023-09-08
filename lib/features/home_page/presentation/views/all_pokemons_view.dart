import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home_page/presentation/controllers/all_pokemons_view_controller.dart';
import 'package:pokedex/features/home_page/presentation/widgets/pokemon_card_widget.dart';

import '../../../../core/data/utils/custom_app_themes.dart';
import '../../../../core/presentation/widgets/app_loading_widget.dart';
import '../widgets/pokemon_logo_widget.dart';

class AllPokemonsView extends GetWidget<AllPokemonsViewController> {
  const AllPokemonsView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController(
      initialScrollOffset: controller.scrollOffset,
    );

    scrollController.addListener(() {
      controller.scrollOffset = scrollController.offset;
    });

    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: controller.error != null ||
                controller.isLoading ||
                controller.pokemons.isEmpty
            ? Column(
                children: [
                  _mobileHeaderWidget,
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
                      !controller.isLoadingMorePokemons) {
                    controller.loadPokemons();
                  }
                  return true;
                },
                child: ListView(
                  controller: scrollController,
                  children: [
                    _mobileHeaderWidget,
                    _pokemonsListWidget,
                    if (controller.isLoadingMorePokemons)
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

  Widget get _mobileHeaderWidget {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 768) return Container();
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
    });
  }

  Widget get _pokemonsListWidget {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      spacing: 5,
      runSpacing: 5,
      children: controller.pokemons.map((pokemonModel) {
        return PokemonCardWidget(
          pokemonModel: pokemonModel,
          isFavorite: controller.favoritesViewController.favorites.contains(
            pokemonModel,
          ),
          toggleFavorite: controller.favoritesViewController.toggleFavorite,
        );
      }).toList(),
    );
  }
}
