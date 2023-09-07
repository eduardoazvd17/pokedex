import 'package:flutter/material.dart';

class PokemonTypeTagWidget extends StatelessWidget {
  const PokemonTypeTagWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.radio_button_checked,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              'Type',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
