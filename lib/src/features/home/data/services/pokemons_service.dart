import 'package:hive/hive.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/core/data/exceptions/app_exception.dart';
import 'package:pokedex/src/core/data/repository/app_repository.dart';
import 'package:pokedex/src/features/home/data/enums/pokemon_type.dart';
import 'package:pokedex/src/features/home/data/models/adapters/pokemon_model_adapter.dart';
import 'package:pokedex/src/features/home/data/models/pokemon_model.dart';

class PokemonsService with AppRepository {
  static const String _endpoint = "https://pokeapi.co/api/v2";
  static const String _favoritesBoxKey = 'favoritesBox';

  Future<List<PokemonModel>> loadPokemons({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final List<PokemonModel> pokemonModels = [];
      final String url = '$_endpoint/pokemon/?limit=$limit&offset=$offset';
      final Map<String, dynamic> response = await get(url: url);
      final pokemonMap = List<Map<String, dynamic>>.from(response['results']);
      for (final Map<String, dynamic> pokemon in pokemonMap) {
        final dataResponse = await get(url: pokemon['url']);
        final String name = dataResponse['name'];
        final int order = dataResponse['order'];
        final String imageUrl =
            dataResponse['sprites']['other']['home']['front_default'];
        final List<PokemonType> types = (dataResponse['types'] as List)
            .map((e) => PokemonTypeExtension.fromName(e['type']['name']))
            .toList();

        pokemonModels.add(
          PokemonModel(
            order: order,
            name: name.replaceFirst(name[0], name[0].toUpperCase()),
            types: types,
            imageUrl: imageUrl,
          ),
        );
      }
      return pokemonModels;
    } on AppException catch (_) {
      rethrow;
    } catch (error) {
      throw AppException(
        'get-all-pokemons-error'.i18n(),
        detailedMessage: error.toString(),
      );
    }
  }

  Future<List<PokemonModel>> loadFavorites() async {
    try {
      Hive.registerAdapter(PokemonModelAdapter(), override: true);
      final Box<PokemonModel> box = await Hive.openBox<PokemonModel>(
        _favoritesBoxKey,
      );
      return box.values.toList();
    } catch (_) {
      return [];
    }
  }

  Future<bool> addToFavorites(PokemonModel model) async {
    try {
      final Box<PokemonModel> box = Hive.box(_favoritesBoxKey);
      box.add(model);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> removeFromFavorites(PokemonModel model) async {
    try {
      final Box<PokemonModel> box = Hive.box(_favoritesBoxKey);
      final int index = box.values.toList().indexOf(model);
      box.deleteAt(index);
      return true;
    } catch (_) {
      return false;
    }
  }
}
