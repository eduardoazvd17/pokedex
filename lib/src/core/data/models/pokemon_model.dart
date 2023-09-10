import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../enums/pokemon_type.dart';

@HiveType(typeId: 1)
class PokemonModel extends Equatable {
  @HiveField(0)
  final int order;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<PokemonType> types;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final double height;

  @HiveField(5)
  final double weight;

  @HiveField(6)
  final String gender;

  @HiveField(7)
  final List<String> abilities;

  const PokemonModel({
    required this.order,
    required this.name,
    required this.types,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.gender,
    required this.abilities,
  });

  String get formattedOrder => '#${order.toString().padLeft(3, '0')}';

  @override
  List<Object?> get props => [order, name];

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    final String name = map['name'];
    final List<PokemonType> types = (map['types'] as List)
        .map((e) => PokemonTypeExtension.fromName(e['type']['name']))
        .toList();

    final String gender = map['gender'] ?? '';

    final List<String> abilities = (map['abilities'] as List)
        .map((e) => e['ability']['name'] as String)
        .toList();

    return PokemonModel(
      order: map['order'],
      name: name.replaceFirst(name[0], name[0].toUpperCase()),
      types: types,
      imageUrl: map['sprites']['other']['official-artwork']['front_default'],
      height: double.parse(map['height'].toString()),
      weight: double.parse(map['weight'].toString()),
      gender: gender,
      abilities: abilities,
    );
  }
}
