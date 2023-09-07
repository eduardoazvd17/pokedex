import 'package:flutter/material.dart';
import 'package:pokedex/core/data/utils/custom_app_themes.dart';

import '../widgets/pokemon_logo_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const PokemonLogoWidget(),
        Column(
          children: [
            _userAvatarWidget,
            const SizedBox(height: 35),
            Text(
              'Eduardo Azevedo',
              textAlign: TextAlign.center,
              style: CustomAppThemes.headerTextStyle,
            ),
            Text(
              'Software Egineer',
              textAlign: TextAlign.center,
              style: CustomAppThemes.bodySmallGreyTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget get _userAvatarWidget {
    const double size = 124;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: size,
          width: size,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.asset(
              'assets/images/profile-picture.png',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 4,
              color: const Color(0xfffdc000),
            ),
          ),
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: const Color(0xff0804b4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
