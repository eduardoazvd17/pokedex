import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/core/presentation/widgets/responsive_builder.dart';
import 'package:pokedex/src/modules/home/presentation/controllers/pokemons_list_controller.dart';
import 'package:pokedex/src/core/presentation/widgets/pokemon_card_widget.dart';

import '../../../../core/presentation/widgets/app_loading_widget.dart';

class PokemonsListPage extends GetWidget<PokemonsListController> {
  const PokemonsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController(
      initialScrollOffset: controller.scrollOffset,
    );

    scrollController.addListener(() {
      controller.scrollOffset = scrollController.offset;
    });

    return Obx(() {
      if (controller.error != null ||
          controller.isLoading ||
          controller.pokemons.isEmpty) {
        return Column(
          children: [
            _responsiveHeaderWidget,
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
        );
      } else {
        return NotificationListener<ScrollNotification>(
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
              _responsiveHeaderWidget,
              _pokemonsListWidget,
              if (controller.isLoadingMorePokemons)
                const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: AppLoadingWidget(),
                ),
            ],
          ),
        );
      }
    });
  }

  Widget get _responsiveHeaderWidget {
    final content = Row(
      children: [
        Expanded(
          child: Text(
            'all-pokemons-list-view-header'.i18n(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
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

  Widget get _pokemonsListWidget {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      spacing: 5,
      runSpacing: 15,
      children: controller.pokemons.map((pokemonModel) {
        return PokemonCardWidget(
          pokemonModel: pokemonModel,
          isFavorite:
              controller.favoritesPokemonsListController.favorites.contains(
            pokemonModel,
          ),
          toggleFavorite:
              controller.favoritesPokemonsListController.toggleFavorite,
        );
      }).toList(),
    );
  }
}
