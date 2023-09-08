import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/core/data/utils/app_theme.dart';
import 'package:pokedex/features/home_page/data/enums/home_page_menu.dart';
import 'package:pokedex/features/home_page/presentation/widgets/pokemon_logo_widget.dart';

import '../../../../core/data/utils/app_icons.dart';
import '../../../../core/presentation/widgets/custom_bottom_navigation_bar.dart';
import '../../../../core/presentation/widgets/custom_top_navigation_bar.dart';
import '../../../../core/presentation/widgets/responsive_builder.dart';
import '../controllers/home_page_controller.dart';

class HomePage extends GetWidget<HomePageController> {
  const HomePage({super.key});

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
                children: HomePageMenu.values.map((e) => e.page).toList(),
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
      padding: const EdgeInsets.only(top: 15, left: 28, right: 28),
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
        bottom: 10,
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
                        icon: item.icon(isSelected: isSelected),
                        label: Text(
                          item.label,
                          style: isSelected
                              ? AppTheme.menuSelectedTextStyle
                              : AppTheme.menuNormalTextStyle,
                        ),
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
              icon: item.icon(isSelected: isSelected),
              label: Text(
                item.label,
                style: isSelected
                    ? AppTheme.menuSelectedTextStyle
                    : AppTheme.menuNormalTextStyle,
              ),
            );
          }).toList(),
        ),
      ),
      desktopWidget: null,
    );
  }
}
