import 'package:flutter/material.dart';

class ResponsibleBuilder extends StatelessWidget {
  final int maxMobileWidth;
  final Widget? mobileWidget;
  final Widget? desktopWidget;

  const ResponsibleBuilder({
    super.key,
    this.maxMobileWidth = 768,
    required this.mobileWidget,
    required this.desktopWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, __) {
        if (MediaQuery.of(context).size.width >= maxMobileWidth) {
          return desktopWidget ?? const SizedBox();
        } else {
          return mobileWidget ?? const SizedBox();
        }
      },
    );
  }
}
