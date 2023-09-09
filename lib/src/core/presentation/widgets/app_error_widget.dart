import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/core/data/exceptions/app_exception.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
  final Function? tryAgain;
  const AppErrorWidget({
    super.key,
    required this.exception,
    this.tryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            CupertinoIcons.exclamationmark_triangle,
            size: 32,
          ).animate().fade().slideY(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              exception.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          if (tryAgain != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  tryAgain?.call();
                },
                child: Text('try-again'.i18n()),
              ),
            ),
        ],
      ),
    );
  }
}
