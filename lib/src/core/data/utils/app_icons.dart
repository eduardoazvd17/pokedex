import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/src/core/data/utils/app_theme.dart';

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

  static Widget linkedin({double? size = 32}) {
    return _svgAsset('assets/icons/linkedin.svg', size: size);
  }

  static Widget instagram({double? size = 32}) {
    return _svgAsset('assets/icons/instagram.svg', size: size);
  }

  static Widget github({double? size = 32}) {
    return _svgAsset('assets/icons/github.svg', size: size);
  }

  static Widget notion({double? size = 32}) {
    return _svgAsset('assets/icons/notion.svg', size: size);
  }

  static Widget whatsapp({double? size = 32}) {
    return _svgAsset('assets/icons/whatsapp.svg', size: size);
  }

  static Widget _svgAsset(String asset,
      {bool isSelected = false, double? size}) {
    const ColorFilter selectedFilter = ColorFilter.mode(
      AppTheme.primaryColor,
      BlendMode.srcIn,
    );

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
