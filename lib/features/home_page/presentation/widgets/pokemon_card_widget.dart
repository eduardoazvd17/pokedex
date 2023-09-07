import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/data/utils/app_theme.dart';

class PokemonCardWidget extends StatelessWidget {
  const PokemonCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Stack(
        children: [
          Card(
            elevation: 1,
            color: Colors.blue[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _content,
            ),
          ),
          Positioned(right: 0, top: 0, bottom: 0, child: _pokeballOverlayImage),
          Positioned(top: 16, right: 16, child: _favoriteButton),
        ],
      ),
    );
  }

  Widget get _content {
    return Row(
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('#007'),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Squirtle',
                  style: AppTheme.title25w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
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
                          'Water',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            height: 120,
            width: 100,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget get _pokeballOverlayImage {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset(
        'assets/images/pokeball-overlay.png',
        color: Colors.black12,
        filterQuality: FilterQuality.low,
        opacity: const AlwaysStoppedAnimation(0.3),
      ),
    );
  }

  Widget get _favoriteButton {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        CupertinoIcons.heart,
        color: Colors.black,
        size: 40,
      ),
    );
  }
}
