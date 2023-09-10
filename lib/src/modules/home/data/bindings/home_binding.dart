import 'package:get/get.dart';

import '../../../../core/data/services/pokemons_service.dart';
import '../../presentation/controllers/favorites_pokemons_list_controller.dart';
import '../../presentation/controllers/home_controller.dart';
import '../../presentation/controllers/pokemons_list_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final PokemonsService service = PokemonsService();
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => FavoritesPokemonsListController(service: service));
    Get.lazyPut(
      () => PokemonsListController(
        service: service,
        favoritesPokemonsListController:
            Get.find<FavoritesPokemonsListController>(),
      ),
    );
  }
}
