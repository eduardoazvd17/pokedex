import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home_page/presentation/controllers/home_page_controller.dart';

import '../../../../core/data/utils/app_theme.dart';
import '../../../../core/presentation/widgets/app_info_widget.dart';
import '../../../../core/presentation/widgets/app_loading_widget.dart';
import '../widgets/pokemon_card_widget.dart';

class FavoritesPokemonsListView extends GetWidget<HomePageController> {
  const FavoritesPokemonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4,
              ),
              child: Image.asset('assets/images/pokemon-logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'favorites-pokemons-list-view-header'.i18n(),
                style: AppTheme.title25w600,
              ),
            ),
            if (controller.error != null)
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 7,
                ),
                child: controller.error!,
              )
            else if (controller.isLoading)
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 5,
                ),
                child: const AppLoadingWidget(),
              )
            else if (controller.favoritesPokemons.isEmpty)
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 6,
                ),
                child: AppInfoWidget(message: 'empty-favorites'.i18n()),
              )
            else
              ...controller.favoritesPokemons.map(
                (pokemonModel) => PokemonCardWidget(
                  pokemonModel: pokemonModel,
                  isFavorite:
                      controller.favoritesOrder.contains(pokemonModel.order),
                  toggleFavorite: controller.toggleFavorite,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
