import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppInfoWidget extends StatelessWidget {
  final String message;
  const AppInfoWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Icon(CupertinoIcons.info_circle, size: 32)
              .animate()
              .fade()
              .slideY(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
