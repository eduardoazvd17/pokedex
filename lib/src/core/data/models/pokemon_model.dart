import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../enums/pokemon_type.dart';

@HiveType(typeId: 1)
class PokemonModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int order;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final List<PokemonType> types;

  @HiveField(4)
  final String imageUrl;

  const PokemonModel({
    required this.id,
    required this.order,
    required this.name,
    required this.types,
    required this.imageUrl,
  });

  String get formattedOrder => '#${order.toString().padLeft(3, '0')}';

  @override
  List<Object?> get props => [order, name];

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    final String name = map['name'];
    final List<PokemonType> types = (map['types'] as List)
        .map((e) => PokemonTypeExtension.fromName(e['type']['name']))
        .toList();

    return PokemonModel(
      id: '${map['id']}',
      order: map['order'],
      name: name.replaceFirst(name[0], name[0].toUpperCase()),
      types: types,
      imageUrl: map['sprites']['other']['official-artwork']['front_default'],
    );
  }
}
