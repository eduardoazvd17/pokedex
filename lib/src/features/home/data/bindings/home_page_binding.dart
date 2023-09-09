import 'package:get/get.dart';
import 'package:pokedex/src/core/data/services/pokemons_service.dart';
import 'package:pokedex/src/features/pokemons_list/presentation/controllers/pokemons_list_controller.dart';
import 'package:pokedex/src/features/home/presentation/controllers/home_page_controller.dart';
import 'package:pokedex/src/features/profile_page/presentation/controllers/profile_controller.dart';

import '../../../favorites_pokemons_list/presentation/controllers/favorites_pokemons_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => FavoritesPokemonsController(service: PokemonsService()));
    Get.lazyPut(
      () => PokemonsListController(
        service: PokemonsService(),
        favoritesViewController: Get.find<FavoritesPokemonsController>(),
      ),
    );
    Get.lazyPut(() => ProfileController());
  }
}
