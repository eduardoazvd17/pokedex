import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../core/data/utils/app_icons.dart';

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

  String get routes {
    return switch (this) {
      HomePageMenu.home => '/home',
      HomePageMenu.favorites => '/favorites',
      HomePageMenu.profile => '/profile',
    };
  }
}
