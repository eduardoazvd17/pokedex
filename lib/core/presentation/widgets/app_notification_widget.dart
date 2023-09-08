import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/utils/custom_app_themes.dart';

class AppNotificationWidget extends StatelessWidget {
  final Widget icon;
  final String text;

  const AppNotificationWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 8,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        width: 207,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFFFD600),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(height: 21, width: 21, child: FittedBox(child: icon)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: CustomAppThemes.snackbarTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fade();
  }
}