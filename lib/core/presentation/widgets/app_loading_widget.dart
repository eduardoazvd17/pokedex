import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CircularProgressIndicator().animate().fade().slideY(),
    );
  }
}
