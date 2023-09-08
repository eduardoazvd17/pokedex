import 'package:flutter/material.dart';

class CustomTopNavigationBar<T> extends StatelessWidget {
  final void Function(T) onChange;
  final List<CustomTopNavigationItem<T>> items;

  const CustomTopNavigationBar({
    super.key,
    required this.onChange,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: items.map((item) {
        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => onChange.call(item.value),
          child: item.toWidget(),
        );
      }).toList(),
    );
  }
}

class CustomTopNavigationItem<T> {
  final T value;
  final Widget icon;
  final Text label;

  CustomTopNavigationItem({
    required this.value,
    required this.icon,
    required this.label,
  });

  Widget toWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: icon,
          ),
          label,
        ],
      ),
    );
  }
}
