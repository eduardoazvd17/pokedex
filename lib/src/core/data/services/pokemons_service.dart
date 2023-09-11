import 'package:hive/hive.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/core/data/exceptions/app_exception.dart';
import 'package:pokedex/src/core/data/models/pokemon_details_dto.dart';
import 'package:pokedex/src/core/data/repository/app_repository.dart';
import 'package:pokedex/src/core/data/models/adapters/pokemon_model_adapter.dart';
import 'package:pokedex/src/core/data/models/pokemon_model.dart';

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
        final Map<String, dynamic> data = await get(url: pokemon['url']);
        pokemonModels.add(PokemonModel.fromMap(data));
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

  Future<PokemonDetailsDTO> loadDetails(PokemonModel model) async {
    try {
      final dataMap =
          await get(url: '$_endpoint/pokemon/${model.name.toLowerCase()}');

      late String gender;
      try {
        final genderMap =
            await get(url: '$_endpoint/gender/${model.name.toLowerCase()}');
        gender = genderMap['name'].replaceFirst(
          genderMap['name'][0],
          genderMap['name'][0].toUpperCase(),
        );
      } catch (_) {
        gender = 'Genderless';
      }

      return PokemonDetailsDTO(
        model: model,
        height: '${dataMap['height'] / 10}m',
        weight: '${dataMap['weight'] / 10}kg',
        gender: gender,
        abilities: dataMap['abilities']
            .map((e) {
              final String name = e['ability']['name'];
              return name.replaceFirst(name[0], name[0].toUpperCase());
            })
            .toString()
            .replaceAll('(', '')
            .replaceAll(')', ''),
        weakenes: [],
        strengths: [],
      );
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
