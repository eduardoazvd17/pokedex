import '../enums/pokemon_type.dart';

class PokemonModel {
  final int order;
  final String name;
  final List<PokemonType> types;
  final String imageUrl;

  PokemonModel({
    required this.order,
    required this.name,
    required this.types,
    required this.imageUrl,
  });

  String get formattedOrder => '#${order.toString().padLeft(3, '0')}';
}
