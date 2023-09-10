import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/modules/home/presentation/controllers/home_page_controller.dart';
import 'package:pokedex/src/modules/home/presentation/pages/home_page.dart';
import 'package:pokedex/src/modules/pokemons_list/pokemons_list_module.dart';
import 'package:pokedex/src/modules/profile_page/profile_module.dart';

import '../favorites_pokemons_list/favorites_pokemons_list_module.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        PokemonsListModule(),
        FavoritesPokemonsListModule(),
        ProfileModule(),
      ];

  @override
  void binds(Injector i) {
    i.add(() => HomePageController());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => HomePage(controller: Modular.get<HomePageController>()),
    );
    r.module('/home', module: PokemonsListModule());
    r.module('/favorites', module: FavoritesPokemonsListModule());
    r.module('/profile', module: ProfileModule());
  }
}
