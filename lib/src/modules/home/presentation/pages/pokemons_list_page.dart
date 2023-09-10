import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/core/presentation/widgets/responsive_builder.dart';
import 'package:pokedex/src/modules/home/presentation/controllers/pokemons_list_controller.dart';
import 'package:pokedex/src/core/presentation/widgets/pokemon_card_widget.dart';

import '../../../../core/presentation/widgets/app_loading_widget.dart';

class PokemonsListPage extends StatelessWidget {
  final PokemonsListController controller;
  const PokemonsListPage({super.key, required this.controller});

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
        );
      } else {
        final Widget content = NotificationListener<ScrollNotification>(
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
              _headerWidget,
              _pokemonsListWidget,
              if (controller.isLoadingMorePokemons)
                const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: AppLoadingWidget(),
                ),
            ],
          ),
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
    });
  }

  Widget get _headerWidget {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Row(
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
