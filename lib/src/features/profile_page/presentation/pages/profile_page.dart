import 'package:flutter/material.dart';
import 'package:pokedex/src/core/presentation/widgets/responsive_builder.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            _responsiveHeaderWidget,
            const Text(
              'Eduardo Azevedo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Software Egineer',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff8A8886),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget get _responsiveHeaderWidget {
    return ResponsiveBuilder(
      mobileWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: _userAvatarWidget,
      ),
      desktopWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 140),
        child: _userAvatarWidget,
      ),
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
