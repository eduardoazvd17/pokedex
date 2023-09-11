import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/core/presentation/widgets/responsive_builder.dart';

import '../../../../core/data/utils/app_icons.dart';

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
      padding: const EdgeInsets.only(left: 28, right: 28),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
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
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: _buttonsWidget,
          ),
          _tilesWidget,
        ],
      ),
    );
  }

  Widget get _desktopWidget {
    return Padding(
      padding: const EdgeInsets.only(
        left: 124,
        right: 124,
        bottom: 10,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 671),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      _profilePictureWidget,
                      const SizedBox(width: 180, height: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: _buttonsWidget,
                      ),
                    ],
                  ),
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
            _tilesWidget,
          ],
        ),
      ),
    );
  }

  Widget get _tilesWidget {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 671),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 11),
            child:
                Text('about-me'.i18n(), style: const TextStyle(fontSize: 14)),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Semper viverra nam libero justo. Sed id semper risus in hendrerit.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff4F4F4F),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 11),
            child: Text('about-project'.i18n(),
                style: const TextStyle(fontSize: 14)),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Protótipo realizado para Guarani Sistemas para o teste para a vaga de Desenvolvedor Flutter Pleno.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff4F4F4F),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 56, bottom: 29),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcons.linkedin(),
                    AppIcons.instagram(),
                    AppIcons.github(),
                    AppIcons.notion(),
                    AppIcons.whatsapp(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buttonsWidget {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {},
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color(0xff040534),
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
            ),
            child: Text(
              'follow-button'.i18n(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {},
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color(0xffD9D9D9),
              ),
              foregroundColor: MaterialStatePropertyAll(
                Color(0xff040534),
              ),
            ),
            child: Text(
              'message-button'.i18n(),
            ),
          ),
        ),
      ],
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
    ).animate().flipH();
  }
}
