import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pokedex/features/home_page/data/enums/home_page_menu.dart';
import 'package:pokedex/features/home_page/data/services/home_service.dart';

import '../../../../core/data/exceptions/app_exception.dart';
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
    _loadAllPokemons();
    super.onInit();
  }

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final Rx<AppException?> _error = Rx<AppException?>(null);
  AppException? get error => _error.value;
  void _clearError() => _error.value = null;

  final RxList<PokemonModel> _allPokemons = RxList<PokemonModel>.empty();
  RxList<PokemonModel> get allPokemons => _allPokemons;
  Future<void> _loadAllPokemons() async {
    _isLoading.value = true;
    try {
      _clearError();
      allPokemons.assignAll(await _service.getAllPokemons());
    } on AppException catch (error) {
      _error.value = error;
    }
    _isLoading.value = false;
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
    super.onClose();
  }
}
