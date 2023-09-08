import 'package:get/get.dart';
import 'package:pokedex/core/presentation/widgets/app_error_widget.dart';
import 'package:pokedex/features/home_page/data/models/pokemon_model.dart';

import '../../../../core/data/exceptions/app_exception.dart';
import '../../../../core/presentation/controllers/app_notifications_controller.dart';
import '../../data/services/pokemons_service.dart';

class FavoritesViewController extends GetxController {
  final PokemonsService _service;
  final NotificationsController notificationsController;
  FavoritesViewController({
    required PokemonsService service,
    required this.notificationsController,
  }) : _service = service;

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final Rx<AppErrorWidget?> _error = Rx<AppErrorWidget?>(null);
  AppErrorWidget? get error => _error.value;

  final RxDouble _listViewScrollOffset = RxDouble(0);
  double get scrollOffset => _listViewScrollOffset.value;
  set scrollOffset(double value) => _listViewScrollOffset.value = value;

  final RxList<PokemonModel> _favorites = RxList<PokemonModel>.empty();
  RxList<PokemonModel> get favorites => _favorites;
  Future<void> loadFavorites() async {
    _isLoading.value = true;
    _error.value = null;
    try {
      favorites.assignAll(await _service.loadFavorites());
    } on AppException catch (exception) {
      _error.value = AppErrorWidget(
        exception: exception,
        tryAgain: loadFavorites,
      );
    }
    _isLoading.value = false;
  }

  void toggleFavorite(PokemonModel model) {
    if (favorites.contains(model)) {
      favorites.remove(model);
      _service.removeFromFavorites(model);
      notificationsController.removedFromFavoritesNotificaitonController.show();
    } else {
      favorites.add(model);
      _service.addToFavorites(model);
      notificationsController.addedToFavoritesNotificationController.show();
    }
  }
}
