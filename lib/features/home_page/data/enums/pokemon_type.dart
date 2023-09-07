import 'package:flutter/material.dart';

enum PokemonType {
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
  unknown,
  shadow,
}

extension PokemonTypeExtension on PokemonType {
  static PokemonType fromName(String name) {
    return PokemonType.values.firstWhere(
      (e) => e.name == name.toLowerCase().trim(),
    );
  }

  Widget get icon => Container();

  Color get color => Colors.blue;

  String get title => name.replaceFirst(name[0], name[0].toUpperCase());
}
