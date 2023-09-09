import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  Widget get icon => SvgPicture.asset(
        'assets/icons/pokemon_types/$name.svg',
        height: 10,
        width: 10,
      );

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
        PokemonType.normal => const Color(0xffFFE0CA),
        PokemonType.fighting => const Color(0xffB8B8B8),
        PokemonType.flying => const Color(0xff95C4E4),
        PokemonType.poison => const Color(0xff8849B0),
        PokemonType.ground => const Color(0xff9E6E53),
        PokemonType.rock => const Color(0xff9A8371),
        PokemonType.bug => const Color(0xffD0EC94),
        PokemonType.ghost => const Color(0xffCDCDCD),
        PokemonType.steel => const Color(0xff7A95AA),
        PokemonType.fire => const Color(0xffEC8C4C),
        PokemonType.water => const Color(0xff20C5F5),
        PokemonType.grass => const Color(0xff70D090),
        PokemonType.electric => const Color(0xffFCF47C),
        PokemonType.psychic => const Color(0xffA98DF8),
        PokemonType.ice => const Color(0xff8FC3E9),
        PokemonType.dragon => const Color(0xffB7DBFF),
        PokemonType.dark => const Color(0xff8D8ECB),
        PokemonType.fairy => const Color(0xffFDB7DA),
        PokemonType.unknown => Colors.grey,
        PokemonType.shadow => Colors.grey,
      };
}
