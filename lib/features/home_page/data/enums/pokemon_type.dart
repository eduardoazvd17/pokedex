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

  String get title => name.replaceFirst(name[0], name[0].toUpperCase());

  Widget get icon => const Icon(Icons.ac_unit, size: 18, color: Colors.white);

  Color get color => switch (this) {
        PokemonType.normal => const Color(0xff7D3600),
        PokemonType.fighting => const Color(0xff0F0905),
        PokemonType.flying => const Color(0xff95C4E4),
        PokemonType.poison => const Color(0xff8849B0),
        PokemonType.ground => const Color(0xff673E2C),
        PokemonType.rock => const Color(0xff54473D),
        PokemonType.bug => const Color(0xff54DC44),
        PokemonType.ghost => const Color(0xff8A8886),
        PokemonType.steel => const Color(0xff5D666E),
        PokemonType.fire => const Color(0xffF10A34),
        PokemonType.water => const Color(0xff265DFC),
        PokemonType.grass => const Color(0xff1B932C),
        PokemonType.electric => const Color(0xffF8A801),
        PokemonType.psychic => const Color(0xff6114BC),
        PokemonType.ice => const Color(0xff8FC3E9),
        PokemonType.dragon => const Color(0xff0804B4),
        PokemonType.dark => const Color(0xff040534),
        PokemonType.fairy => const Color(0xffFF48CC),
        PokemonType.unknown => Colors.grey[600]!,
        PokemonType.shadow => Colors.grey[600]!,
      };

  Color get backgroundColor => switch (this) {
        PokemonType.normal => const Color(0xff7D3600),
        PokemonType.fighting => const Color(0xff0F0905),
        PokemonType.flying => const Color(0xff95C4E4),
        PokemonType.poison => const Color(0xff8849B0),
        PokemonType.ground => const Color(0xff673E2C),
        PokemonType.rock => const Color(0xff54473D),
        PokemonType.bug => const Color(0xff54DC44),
        PokemonType.ghost => const Color(0xff8A8886),
        PokemonType.steel => const Color(0xff5D666E),
        PokemonType.fire => const Color(0xffF10A34),
        PokemonType.water => const Color(0xff265DFC),
        PokemonType.grass => const Color(0xff1B932C),
        PokemonType.electric => const Color(0xffF8A801),
        PokemonType.psychic => const Color(0xff6114BC),
        PokemonType.ice => const Color(0xff8FC3E9),
        PokemonType.dragon => const Color(0xff0804B4),
        PokemonType.dark => const Color(0xff040534),
        PokemonType.fairy => const Color(0xffFF48CC),
        PokemonType.unknown => Colors.grey,
        PokemonType.shadow => Colors.grey,
      };
}
