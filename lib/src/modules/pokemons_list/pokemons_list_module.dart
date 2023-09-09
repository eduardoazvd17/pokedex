import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/modules/favorites_pokemons_list/favorites_pokemons_list_module.dart';
import 'package:pokedex/src/modules/favorites_pokemons_list/presentation/controllers/favorites_pokemons_list_controller.dart';

import '../../core/data/services/pokemons_service.dart';
import 'presentation/controllers/pokemons_list_controller.dart';
import 'presentation/pages/pokemons_list_page.dart';

class PokemonsListModule extends Module {
  @override
  List<Module> get imports => [FavoritesPokemonsListModule()];

  @override
  void binds(Injector i) {
    i.add(
      () => PokemonsListController(
        service: PokemonsService(),
        favoritesPokemonsListController:
            Modular.get<FavoritesPokemonsListController>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/home',
      child: (_) => PokemonsListPage(
        controller: Modular.get<PokemonsListController>(),
      ),
    );
  }
}
