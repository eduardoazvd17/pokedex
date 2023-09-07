import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/core/data/utils/app_theme.dart';

class AppIcons {
  static Widget home({bool isSelected = false}) {
    return _svgAsset(
      'assets/icons/home-icon.svg',
      isSelected: isSelected,
    );
  }

  static Widget favorites({bool isSelected = false}) {
    return _svgAsset(
      'assets/icons/pokeball-icon.svg',
      isSelected: isSelected,
    );
  }

  static Widget profile({bool isSelected = false}) {
    return _svgAsset(
      'assets/icons/profile-icon.svg',
      isSelected: isSelected,
    );
  }

  static Widget settings({bool isSelected = false}) {
    return _svgAsset(
      'assets/icons/settings-icon.svg',
      isSelected: isSelected,
    );
  }

  static Widget notification({bool isSelected = false}) {
    return _svgAsset(
      'assets/icons/notification-icon.svg',
      isSelected: isSelected,
    );
  }

  static Widget heart({bool isSelected = false}) {
    return _svgAsset(
      isSelected ? 'assets/icons/heart-fill.svg' : 'assets/icons/heart.svg',
    );
  }

  static Widget _svgAsset(String asset, {bool isSelected = false}) {
    final ColorFilter normalFilter =
        ColorFilter.mode(AppTheme.foregroundColor, BlendMode.srcIn);

    final ColorFilter selectedFilter =
        ColorFilter.mode(AppTheme.primaryColor, BlendMode.srcIn);

    return SvgPicture.asset(
      asset,
      colorFilter: isSelected ? selectedFilter : normalFilter,
      height: 30,
      width: 30,
    );
  }
}
