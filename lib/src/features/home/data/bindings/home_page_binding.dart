import 'package:get/get.dart';
import 'package:pokedex/src/features/home/data/services/pokemons_service.dart';
import 'package:pokedex/src/features/home/presentation/controllers/home_view_controller.dart';
import 'package:pokedex/src/features/home/presentation/controllers/home_page_controller.dart';

import '../../presentation/controllers/favorites_view_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => FavoritesViewController(service: PokemonsService()));
    Get.lazyPut(
      () => HomeViewController(
        service: PokemonsService(),
        favoritesViewController: Get.find<FavoritesViewController>(),
      ),
    );
  }
}
