import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
        top: 10,
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
    );
  }
}

class CustomBottomNavigationItem<T> {
  final T value;
  final Widget icon;
  final Text label;

  CustomBottomNavigationItem({
    required this.value,
    required this.icon,
    required this.label,
  });

  Widget toWidget() {
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
          label,
        ],
      ),
    );
  }
}
