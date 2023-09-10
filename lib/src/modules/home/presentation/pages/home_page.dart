import 'package:flutter/material.dart';
import 'package:get/get.dart' hide RouterOutlet;
import 'package:pokedex/src/modules/home/data/enums/home_page_menu.dart';
import 'package:pokedex/src/core/presentation/widgets/pokemon_logo_widget.dart';
import 'package:pokedex/src/modules/home/presentation/controllers/pokemons_list_controller.dart';
import 'package:pokedex/src/modules/home/presentation/pages/pokemons_list_page.dart';
import 'package:pokedex/src/modules/home/presentation/pages/profile_page.dart';

import '../../../../core/data/utils/app_icons.dart';
import '../../../../core/presentation/widgets/custom_bottom_navigation_bar.dart';
import '../../../../core/presentation/widgets/custom_top_navigation_bar.dart';
import '../../../../core/presentation/widgets/responsive_builder.dart';
import '../controllers/favorites_pokemons_list_controller.dart';
import '../controllers/home_controller.dart';
import 'favorites_pokemons_list_page.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;
  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ResponsiveBuilder(
              mobileWidget: _mobileAppBar,
              desktopWidget: _desktopAppBar,
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                children: HomePageMenu.values
                    .map((e) => switch (e) {
                          HomePageMenu.home => PokemonsListPage(
                              controller: Get.find<PokemonsListController>(),
                            ),
                          HomePageMenu.favorites => FavoritesPokemonsListPage(
                              controller:
                                  Get.find<FavoritesPokemonsListController>(),
                            ),
                          HomePageMenu.profile => const ProfilePage(),
                        })
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget get _mobileAppBar {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 28, right: 28, bottom: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: AppIcons.settings(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: AppIcons.notification(),
                ),
              ],
            ),
          ),
          const Positioned(bottom: 10, child: PokemonLogoWidget()),
        ],
      ),
    );
  }

  Widget get _desktopAppBar {
    return Padding(
      padding: const EdgeInsets.only(
        top: 35,
        left: 124,
        right: 124,
        bottom: 35,
      ),
      child: Column(
        children: [
          const PokemonLogoWidget(),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(
                  () => CustomTopNavigationBar(
                    onChange: controller.changePage,
                    items: HomePageMenu.values.map((item) {
                      final bool isSelected = controller.currentPage == item;
                      return CustomTopNavigationItem(
                        value: item,
                        isSelected: isSelected,
                        icon: item.icon(isSelected: isSelected),
                        label: item.label,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: AppIcons.notification(),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {},
                    icon: AppIcons.settings(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return ResponsiveBuilder(
      mobileWidget: Obx(
        () => CustomBottomNavigationBar(
          onChange: controller.changePage,
          items: HomePageMenu.values.map((item) {
            final bool isSelected = controller.currentPage == item;
            return CustomBottomNavigationItem(
              value: item,
              isSelected: isSelected,
              icon: item.icon(isSelected: isSelected),
              label: item.label,
            );
          }).toList(),
        ),
      ),
      desktopWidget: null,
    );
  }
}
