import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/core/data/exceptions/app_exception.dart';
import 'package:pokedex/src/core/data/models/pokemon_details_dto.dart';
import 'package:pokedex/src/core/data/repository/app_repository.dart';
import 'package:pokedex/src/core/data/models/adapters/pokemon_model_adapter.dart';
import 'package:pokedex/src/core/data/models/pokemon_model.dart';

class PokemonsService with AppRepository {
  static const String _endpoint = 'https://pokeapi.co/api/v2';
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
      final dataMap = await get(url: '$_endpoint/pokemon/${model.id}');

      late String gender;
      try {
        final genderMap = await get(url: '$_endpoint/gender/${model.id}');
        gender = genderMap['name'].replaceFirst(
          genderMap['name'][0],
          genderMap['name'][0].toUpperCase(),
        );
      } catch (_) {
        gender = 'Genderless';
      }

      final specieMap =
          await get(url: '$_endpoint/pokemon-species/${model.id}');

      final String category = specieMap['genera']
          .firstWhere((e) => e['language']['name'] == 'en')['genus']
          .replaceAll('Pokémon', '');

      final String flavorText =
          List<Map<String, dynamic>>.from(specieMap['flavor_text_entries'])
                  .firstWhereOrNull((e) {
                return e['version']['name'] == 'firered' &&
                    e['language']['name'] == 'en';
              })?['flavor_text'] ??
              specieMap['flavor_text_entries'][0]['flavor_text'];

      final List<String> moves =
          List<Map<String, dynamic>>.from(dataMap['moves']).map((e) {
        String name = e['move']['name'].toString();

        String formattedName = '';
        for (final String part in name.split('-')) {
          formattedName +=
              '${part.replaceFirst(part[0], part[0].toUpperCase())} ';
        }
        return formattedName.trim();
      }).toList();

      return PokemonDetailsDTO(
        model: model,
        flavorText: flavorText,
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
        stats: (dataMap['stats'] as List).map((e) {
          String label = e['stat']['name'].toString();
          if (label == 'hp') {
            label = label.toUpperCase();
          } else if (label.contains('special-')) {
            label = label
                .replaceAll('special-attack', 'Sp. Atk')
                .replaceAll('special-defense', 'Sp. Def');
          } else {
            label = label.replaceFirst(label[0], label[0].toUpperCase());
          }

          return {
            'label': label,
            'value': e['base_stat'],
          };
        }),
        category: category,
        moves: moves,
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
