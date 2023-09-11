import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/core/data/models/pokemon_model.dart';
import 'package:pokedex/src/core/data/services/pokemons_service.dart';
import 'package:pokedex/src/modules/home/data/enums/details_page_menu.dart';

import '../../../../core/data/exceptions/app_exception.dart';
import '../../../../core/data/models/pokemon_details_dto.dart';
import '../../../../core/presentation/widgets/app_error_widget.dart';
import '../pages/details_page.dart';
import 'favorites_pokemons_list_controller.dart';

class DetailsController extends GetxController {
  final PokemonsService _service;
  final FavoritesPokemonsListController favoritesPokemonsListController;
  DetailsController({
    required PokemonsService service,
    required this.favoritesPokemonsListController,
  }) : _service = service;

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final Rx<AppErrorWidget?> _error = Rx<AppErrorWidget?>(null);
  AppErrorWidget? get error => _error.value;

  final Rx<PokemonDetailsDTO?> _details = Rx<PokemonDetailsDTO?>(null);
  PokemonDetailsDTO? get details => _details.value;

  final Rx<DetailsPageMenu> _currentPage =
      Rx<DetailsPageMenu>(DetailsPageMenu.about);
  DetailsPageMenu get currentPage => _currentPage.value;
  void changePage(DetailsPageMenu page) {
    _currentPage.value = page;
  }

  bool isFavorite(PokemonModel pokemonModel) =>
      favoritesPokemonsListController.favorites.contains(pokemonModel);

  open(BuildContext context, PokemonModel pokemonModel) {
    changePage(DetailsPageMenu.about);
    loadDetails(pokemonModel);
    showDialog(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      builder: (_) {
        return DetailsPage(controller: this, pokemonModel: pokemonModel);
      },
    );
  }

  Future<void> loadDetails(PokemonModel pokemonModel) async {
    _isLoading.value = true;
    _error.value = null;
    try {
      _details.value = await _service.loadDetails(pokemonModel);
    } on AppException catch (exception) {
      _error.value = AppErrorWidget(
        exception: exception,
        tryAgain: () => loadDetails(pokemonModel),
      );
    }
    _isLoading.value = false;
  }
}
