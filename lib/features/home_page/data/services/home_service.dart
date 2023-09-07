import 'package:localization/localization.dart';
import 'package:pokedex/core/data/exceptions/app_exception.dart';
import 'package:pokedex/core/data/services/app_service.dart';
import 'package:pokedex/features/home_page/data/models/pokemon_model.dart';

class HomeService extends AppService {
  static const String _endpoint = "https://pokeapi.co/api/v2";

  Future<List<PokemonModel>> getAllPokemons() async {
    try {
      const String url = '$_endpoint/pokemon/?limit=-1';
      final Map<String, dynamic> response = await get(url: url);
      return List<Map<String, dynamic>>.from(response['results'])
          .map((map) => PokemonModel.fromMap(map))
          .toList();
    } catch (_) {
      throw AppException('get-all-pokemons-error'.i18n());
    }
  }
}
