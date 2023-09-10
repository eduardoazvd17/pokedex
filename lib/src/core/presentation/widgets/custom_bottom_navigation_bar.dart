import 'package:flutter/material.dart';

import '../../data/utils/app_theme.dart';

class CustomBottomNavigationBar<T> extends StatelessWidget {
  final void Function(T) onChange;
  final List<CustomBottomNavigationItem<T>> items;

  const CustomBottomNavigationBar({
    super.key,
    required this.onChange,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            top: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items.map((item) {
              return InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () => onChange.call(item.value),
                child: item.toWidget(),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CustomBottomNavigationItem<T> {
  final T value;
  final bool isSelected;
  final Widget icon;
  final String label;

  CustomBottomNavigationItem({
    required this.value,
    required this.isSelected,
    required this.icon,
    required this.label,
  });

  Widget toWidget() {
    const normalStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );

    const selectedStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      color: AppTheme.primaryColor,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: icon,
          ),
          Text(label, style: isSelected ? selectedStyle : normalStyle),
        ],
      ),
    );
  }
}
