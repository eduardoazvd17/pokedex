import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home_page/presentation/views/favorites_view.dart';
import 'package:pokedex/features/home_page/presentation/views/profile_view.dart';

import '../../../../core/data/utils/custom_app_icons.dart';
import '../../presentation/views/all_pokemons_view.dart';

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
      HomePageMenu.home => CustomAppIcons.home(isSelected: isSelected),
      HomePageMenu.favorites =>
        CustomAppIcons.favorites(isSelected: isSelected),
      HomePageMenu.profile => CustomAppIcons.profile(isSelected: isSelected),
    };
  }

  Widget get page {
    return switch (this) {
      HomePageMenu.home => const AllPokemonsView(),
      HomePageMenu.favorites => const FavoritesPokemonsListView(),
      HomePageMenu.profile => const ProfileView(),
    };
  }
}
