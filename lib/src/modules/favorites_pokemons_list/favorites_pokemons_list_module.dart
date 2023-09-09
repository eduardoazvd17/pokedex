import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/core/data/services/pokemons_service.dart';
import 'package:pokedex/src/modules/favorites_pokemons_list/presentation/controllers/favorites_pokemons_list_controller.dart';

import 'presentation/pages/favorites_pokemons_list_page.dart';

class FavoritesPokemonsListModule extends Module {
  @override
  void binds(Injector i) {
    i.add(() => FavoritesPokemonsListController(service: PokemonsService()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/favorites',
      child: (_) => FavoritesPokemonsListPage(
        controller: Modular.get<FavoritesPokemonsListController>(),
      ),
    );
  }
}
