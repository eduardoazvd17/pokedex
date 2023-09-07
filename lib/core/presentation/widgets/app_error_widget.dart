import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/core/data/exceptions/app_exception.dart';

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
          Text(
            exception.message,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (tryAgain != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
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
