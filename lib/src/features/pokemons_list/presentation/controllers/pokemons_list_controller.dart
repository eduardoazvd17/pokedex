import 'package:get/get.dart';
import 'package:pokedex/src/core/presentation/widgets/app_error_widget.dart';
import 'package:pokedex/src/core/data/models/pokemon_model.dart';
import 'package:pokedex/src/features/favorites_pokemons_list/presentation/controllers/favorites_pokemons_controller.dart';

import '../../../../core/data/exceptions/app_exception.dart';
import '../../../../core/data/services/pokemons_service.dart';

class PokemonsListController extends GetxController {
  final PokemonsService _service;
  final FavoritesPokemonsController favoritesViewController;
  PokemonsListController({
    required PokemonsService service,
    required this.favoritesViewController,
  }) : _service = service;

  @override
  void onInit() {
    loadPokemons(reload: true);
    super.onInit();
  }

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final RxBool _isLoadingMorePokemons = RxBool(false);
  bool get isLoadingMorePokemons => _isLoadingMorePokemons.value;

  final Rx<AppErrorWidget?> _error = Rx<AppErrorWidget?>(null);
  AppErrorWidget? get error => _error.value;

  final RxDouble _listViewScrollOffset = RxDouble(0);
  double get scrollOffset => _listViewScrollOffset.value;
  set scrollOffset(double value) => _listViewScrollOffset.value = value;

  final RxList<PokemonModel> _pokemons = RxList<PokemonModel>.empty();
  RxList<PokemonModel> get pokemons => _pokemons;
  Future<void> loadPokemons({bool reload = false}) async {
    _isLoading.value = reload || pokemons.isEmpty;
    _isLoadingMorePokemons.value = !reload && pokemons.isNotEmpty;
    _error.value = null;
    try {
      if (reload) {
        pokemons.assignAll(
          await _service.loadPokemons(),
        );
      } else {
        pokemons.addAll(
          await _service.loadPokemons(offset: pokemons.length),
        );
      }
    } on AppException catch (exception) {
      _error.value = AppErrorWidget(
        exception: exception,
        tryAgain: loadPokemons,
      );
    }
    _isLoading.value = false;
    _isLoadingMorePokemons.value = false;
  }
}
