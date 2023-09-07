import 'package:flutter/material.dart';

class CustomAssetIcon extends StatelessWidget {
  final String asset;
  final double size;
  final bool isSelected;
  const CustomAssetIcon({
    super.key,
    required this.asset,
    this.size = 25,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: size,
      height: size,
    );
  }
}
