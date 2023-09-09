import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/features/favorites_pokemons_list/presentation/pages/favorites_pokemons_page.dart';
import 'package:pokedex/src/features/profile_page/presentation/pages/profile_page.dart';

import '../../../../core/data/utils/app_icons.dart';
import '../../../pokemons_list/presentation/pages/pokemons_list_page.dart';

enum HomePageMenu {
  home,
  favorites,
  profile,
}

extension HomePageMenuExtension on HomePageMenu {
  String get label {
    return switch (this) {
      HomePageMenu.home => 'home-label'.i18n(),
      HomePageMenu.favorites => 'favorites-label'.i18n(),
      HomePageMenu.profile => 'profile-label'.i18n(),
    };
  }

  Widget icon({required bool isSelected}) {
    return switch (this) {
      HomePageMenu.home => AppIcons.home(isSelected: isSelected),
      HomePageMenu.favorites => AppIcons.favorites(isSelected: isSelected),
      HomePageMenu.profile => AppIcons.profile(isSelected: isSelected),
    };
  }

  Widget get page {
    return switch (this) {
      HomePageMenu.home => const PokemonsListPage(),
      HomePageMenu.favorites => const FavoritesPokemonsPage(),
      HomePageMenu.profile => const ProfilePage(),
    };
  }
}
