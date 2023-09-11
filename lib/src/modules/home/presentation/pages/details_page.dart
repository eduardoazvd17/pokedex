import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:pokedex/src/core/data/enums/pokemon_type.dart';
import 'package:pokedex/src/core/presentation/widgets/responsive_builder.dart';
import 'package:pokedex/src/modules/home/data/enums/details_page_menu.dart';
import 'package:pokedex/src/modules/home/presentation/controllers/details_controller.dart';

import '../../../../core/data/models/pokemon_model.dart';
import '../../../../core/data/utils/app_icons.dart';
import '../../../../core/data/utils/app_theme.dart';
import '../../../../core/presentation/widgets/app_loading_widget.dart';
import '../../../../core/presentation/widgets/app_notification_widget.dart';
import '../../../../core/presentation/widgets/pokemon_type_tag_widget.dart';
import '../controllers/home_controller.dart';

class DetailsPage extends StatelessWidget {
  final DetailsController controller;
  final PokemonModel pokemonModel;
  const DetailsPage({
    super.key,
    required this.controller,
    required this.pokemonModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Navigator.of(context).pop,
      child: ResponsiveBuilder(
        mobileWidget: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 108.0),
            child: _content,
          ),
        ),
        desktopWidget: _content,
      ),
    );
  }

  Widget get _content {
    return Material(
      color: Colors.black87,
      child: GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 789,
                maxHeight: 624,
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          ClipPath(
                            clipper: CustomBorderClipper(),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  radius: 4,
                                  focal: Alignment.center,
                                  colors: [
                                    pokemonModel.types.first.backgroundColor,
                                    Colors.black,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Obx(() => _pageTabs),
                        ],
                      ),
                      Positioned(
                        bottom: 55,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Transform.flip(
                                flipX: true,
                                child: Image.network(
                                  pokemonModel.imageUrl,
                                  height: 216,
                                  width: 204,
                                ),
                              ).animate().slideX(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pokemonModel.formattedOrder,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      pokemonModel.name,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Wrap(
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: pokemonModel.types
                                        .map((e) => PokemonTypeTagWidget(
                                            pokemonType: e))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 25,
                        right: 15,
                        child: Obx(
                          () => IconButton(
                            onPressed: () {
                              _displayNotification(
                                  controller.isFavorite(pokemonModel));
                              controller.favoritesPokemonsListController
                                  .toggleFavorite(pokemonModel);
                            },
                            icon: AppIcons.heart(
                              isSelected: controller.isFavorite(pokemonModel),
                              size: 35,
                            ).animate().slideY().fade(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xffF7F7F7),
                      child: ListView(
                        children: [
                          _selectedTabContent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _pageTabs {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: DetailsPageMenu.values.map((e) {
              return InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () => controller.changePage(e),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e.title,
                    style: TextStyle(
                      color: Colors.transparent,
                      shadows: [
                        Shadow(
                          color: controller.currentPage == e
                              ? AppTheme.primaryColor
                              : Colors.black,
                          offset: const Offset(0, -5),
                        ),
                      ],
                      fontSize: 14,
                      fontWeight: controller.currentPage == e
                          ? FontWeight.w700
                          : FontWeight.w400,
                      decoration: controller.currentPage == e
                          ? TextDecoration.underline
                          : null,
                      decorationThickness: 2,
                      decorationColor: AppTheme.primaryColor,
                    ),
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }

  Widget get _selectedTabContent {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 64),
      child: Obx(
        () {
          if (controller.isLoading || controller.error != null) {
            return controller.error ?? const AppLoadingWidget();
          }

          return switch (controller.currentPage) {
            DetailsPageMenu.about => _aboutTabContent.animate().fade(),
            _ => Container(),
          };
        },
      ),
    );
  }

  Widget get _aboutTabContent => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Semper viverra nam libero justo. Sed id semper risus in hendrerit.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff555252),
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'height-text'.i18n(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff555252),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppIcons.height(),
                        const SizedBox(width: 5),
                        Text(
                          controller.details!.height,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'weight-text'.i18n(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff555252),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppIcons.weight(),
                        const SizedBox(width: 5),
                        Text(
                          controller.details!.weight,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'gender-text'.i18n(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff555252),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppIcons.gender(),
                        const SizedBox(width: 5),
                        Text(
                          controller.details!.gender.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double maxWidth = constraints.maxWidth;
                final double itemWidth = maxWidth / 3;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: itemWidth + 25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'category-text'.i18n(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff555252),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('...'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'abilities-text'.i18n(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff555252),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(controller.details!.abilities),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          if (controller.details!.weakenes.isNotEmpty) ...[
            Text(
              'weakenes-text'.i18n(),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff555252),
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: controller.details!.weakenes
                    .map((e) => PokemonTypeTagWidget(pokemonType: e))
                    .toList(),
              ),
            ),
          ],
          if (controller.details!.strengths.isNotEmpty) ...[
            Text(
              'strength-text'.i18n(),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff555252),
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: controller.details!.strengths
                    .map((e) => PokemonTypeTagWidget(pokemonType: e))
                    .toList(),
              ),
            ),
          ],
        ],
      );

  Future<void> _displayNotification(bool isFavorite) async {
    if (Get.isRegistered<HomeController>()) {
      final AppNotificationWidget notification = isFavorite
          ? AppNotificationWidget(
              icon: AppIcons.heart(),
              text: 'removed-from-favorite'.i18n(),
            )
          : AppNotificationWidget(
              icon: AppIcons.heart(isSelected: true),
              text: 'added-to-favorite'.i18n(),
            );
      Get.find<HomeController>().showNotification(notification);
    }
  }
}

class CustomBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 80);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, 221);
    path.lineTo(0, 221);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
