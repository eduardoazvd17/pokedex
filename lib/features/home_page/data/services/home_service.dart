import 'package:localization/localization.dart';
import 'package:pokedex/core/data/exceptions/app_exception.dart';
import 'package:pokedex/core/data/services/app_service.dart';
import 'package:pokedex/features/home_page/data/enums/pokemon_type.dart';
import 'package:pokedex/features/home_page/data/models/pokemon_model.dart';

class HomeService extends AppService {
  static const String _endpoint = "https://pokeapi.co/api/v2";

  Future<List<PokemonModel>> getAllPokemons() async {
    try {
      final List<PokemonModel> pokemonModels = [];
      const String url = '$_endpoint/pokemon/?limit=20';
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
}
