import 'package:pokedex/src/core/data/enums/pokemon_type.dart';
import 'package:pokedex/src/core/data/models/pokemon_model.dart';

class PokemonDetailsDTO {
  final PokemonModel model;
  final String flavorText;
  final String height;
  final String weight;
  final String gender;
  final String abilities;
  final List<PokemonType> weakenes;
  final List<PokemonType> strengths;
  final String category;
  final List<String> moves;

  final Iterable<Map<String, dynamic>> stats;

  PokemonDetailsDTO({
    required this.model,
    required this.flavorText,
    required this.height,
    required this.weight,
    required this.gender,
    required this.abilities,
    required this.weakenes,
    required this.strengths,
    required this.stats,
    required this.category,
    required this.moves,
  });
}
