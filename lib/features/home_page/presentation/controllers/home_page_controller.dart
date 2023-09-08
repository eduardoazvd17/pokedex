import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pokedex/features/home_page/data/enums/home_page_menu.dart';
import 'package:pokedex/features/home_page/data/services/home_service.dart';

import '../../../../core/data/exceptions/app_exception.dart';
import '../../../../core/presentation/widgets/app_error_widget.dart';
import '../../data/models/pokemon_model.dart';

class HomePageController extends GetxController {
  final HomeService _service;
  HomePageController({required HomeService service}) : _service = service;

  @override
  void onInit() {
    pageController.addListener(() {
      _currentPage.value =
          HomePageMenu.values[_pageController.page?.round() ?? 0];
    });
    loadPokemons(reload: true);
    super.onInit();
  }

  final ScrollController _allPokemonsListController = ScrollController();
  ScrollController get allPokemonsListController => _allPokemonsListController;

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final RxBool _isLoadingMore = RxBool(false);
  bool get isLoadingMore => _isLoadingMore.value;

  final Rx<AppErrorWidget?> _error = Rx<AppErrorWidget?>(null);
  AppErrorWidget? get error => _error.value;
  void _clearError() => _error.value = null;

  final RxSet<int> _favorites = RxSet<int>({});
  RxSet<int> get favoritesOrder => _favorites;
  List<PokemonModel> get favoritesPokemons =>
      _allPokemons.where((e) => favoritesOrder.contains(e.order)).toList();
  void toggleFavorite(int order) {
    if (favoritesOrder.contains(order)) {
      favoritesOrder.remove(order);
    } else {
      favoritesOrder.add(order);
    }
  }

  final RxList<PokemonModel> _allPokemons = RxList<PokemonModel>.empty();
  RxList<PokemonModel> get allPokemons => _allPokemons;

  Future<void> loadPokemons({bool reload = false}) async {
    _isLoading.value = reload || allPokemons.isEmpty;
    _isLoadingMore.value = !reload && allPokemons.isNotEmpty;
    try {
      _clearError();
      if (reload) {
        allPokemons.assignAll(
          await _service.loadPokemons(),
        );
      } else {
        allPokemons.addAll(
          await _service.loadPokemons(offset: allPokemons.length),
        );
      }
    } on AppException catch (exception) {
      _error.value = AppErrorWidget(
        exception: exception,
        tryAgain: loadPokemons,
      );
    }
    _isLoading.value = false;
    _isLoadingMore.value = false;
  }

  final Rx<HomePageMenu> _currentPage = Rx<HomePageMenu>(HomePageMenu.home);
  HomePageMenu get currentPage => _currentPage.value;
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  void changePage(HomePageMenu page) {
    pageController.animateToPage(
      HomePageMenu.values.indexOf(page),
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void onClose() {
    _pageController.dispose();
    _allPokemonsListController.dispose();
    super.onClose();
  }
}
