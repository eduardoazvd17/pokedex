import 'package:flutter/material.dart';
import 'package:iconoir_flutter/home_alt.dart';
import 'package:iconoir_flutter/pokeball.dart';
import 'package:iconoir_flutter/profile_circle.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/features/home_page/presentation/views/favorites_pokemons_list_view.dart';
import 'package:pokedex/features/home_page/presentation/views/profile_view.dart';

import '../../presentation/views/all_pokemons_list_view.dart';

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

  Widget icon({
    required BuildContext context,
    required bool isSelected,
  }) {
    return switch (this) {
      HomePageMenu.home => HomeAlt(
          color: isSelected ? Theme.of(context).primaryColor : null,
        ),
      HomePageMenu.favorites => Pokeball(
          color: isSelected ? Theme.of(context).primaryColor : null,
        ),
      HomePageMenu.profile => ProfileCircle(
          color: isSelected ? Theme.of(context).primaryColor : null,
        ),
    };
  }

  Widget get page {
    return switch (this) {
      HomePageMenu.home => const AllPokemonsListView(),
      HomePageMenu.favorites => const FavoritesPokemonsListView(),
      HomePageMenu.profile => const ProfileView(),
    };
  }
}
