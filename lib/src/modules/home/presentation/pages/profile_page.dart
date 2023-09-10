import 'package:flutter/material.dart';
import 'package:pokedex/src/core/presentation/widgets/responsive_builder.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ResponsiveBuilder(
          mobileWidget: _mobileWidget,
          desktopWidget: _desktopWidget,
        ),
      ],
    );
  }

  Widget get _mobileWidget {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 28, right: 28),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _profilePictureWidget,
          ),
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
    );
  }

  Widget get _desktopWidget {
    return Padding(
      padding: const EdgeInsets.only(
        top: 35,
        left: 124,
        right: 124,
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: _profilePictureWidget,
                  ),
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
          ),
        ],
      ),
    );
  }

  Widget get _profilePictureWidget {
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
