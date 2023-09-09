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

  const PokemonModel({
    required this.order,
    required this.name,
    required this.types,
    required this.imageUrl,
  });

  String get formattedOrder => '#${order.toString().padLeft(3, '0')}';

  @override
  List<Object?> get props => [order, name];
}
