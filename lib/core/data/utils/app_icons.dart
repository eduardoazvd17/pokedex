import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/core/data/utils/app_theme.dart';

class AppIcons {
  static Widget home({bool isSelected = false}) {
    return Stack(
      children: [
        _svgAsset(
          'assets/icons/home-icon.svg',
          isSelected: isSelected,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _svgAsset(
            'assets/icons/home-icon-overlay.svg',
            isSelected: isSelected,
            size: 9,
          ),
        ),
      ],
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

  static Widget heart({bool isSelected = false, double? size}) {
    return _svgAsset(
      isSelected ? 'assets/icons/heart-fill.svg' : 'assets/icons/heart.svg',
      size: size,
    );
  }

  static Widget _svgAsset(String asset,
      {bool isSelected = false, double? size}) {
    final ColorFilter selectedFilter =
        ColorFilter.mode(AppTheme.primaryColor, BlendMode.srcIn);

    return SizedBox(
      height: size ?? 24,
      width: size ?? 24,
      child: FittedBox(
        child: SvgPicture.asset(
          asset,
          colorFilter: isSelected ? selectedFilter : null,
        ),
      ),
    );
  }
}
