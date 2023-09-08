import 'package:get/get.dart';
import 'package:pokedex/features/home_page/data/services/pokemons_service.dart';
import 'package:pokedex/features/home_page/presentation/controllers/all_pokemons_view_controller.dart';
import 'package:pokedex/features/home_page/presentation/controllers/home_page_controller.dart';

import '../../presentation/controllers/favorites_view_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => FavoritesViewController(service: PokemonsService()));
    Get.lazyPut(
      () => AllPokemonsViewController(
        service: PokemonsService(),
        favoritesViewController: Get.find<FavoritesViewController>(),
      ),
    );
  }
}
