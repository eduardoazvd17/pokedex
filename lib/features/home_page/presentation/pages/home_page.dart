import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/core/data/utils/app_sizes.dart';
import 'package:pokedex/core/data/utils/custom_app_themes.dart';
import 'package:pokedex/features/home_page/data/enums/home_page_menu.dart';
import 'package:pokedex/features/home_page/presentation/widgets/pokemon_logo_widget.dart';

import '../../../../core/data/utils/custom_app_icons.dart';
import '../../../../core/presentation/widgets/custom_bottom_navigation_bar.dart';
import '../../../../core/presentation/widgets/custom_top_navigation_bar.dart';
import '../../../../core/presentation/widgets/responsible_builder.dart';
import '../controllers/home_page_controller.dart';

class HomePage extends GetWidget<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ResponsibleBuilder(
              mobileWidget: _mobileHeader,
              desktopWidget: _desktopHeader,
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
      bottomNavigationBar: _mobileBottomNavigationBar(context),
    );
  }

  Widget get _mobileHeader {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.mobileAppPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: CustomAppIcons.settings(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: CustomAppIcons.notification(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _desktopHeader {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.desktopAppPadding),
      child: Column(
        children: [
          const PokemonLogoWidget(),
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
                              ? CustomAppThemes.menuSelectedTextStyle
                              : CustomAppThemes.menuNormalTextStyle,
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
                    icon: CustomAppIcons.notification(),
                  ),
                  const SizedBox(width: AppSizes.desktopWidgetSpacing),
                  IconButton(
                    onPressed: () {},
                    icon: CustomAppIcons.settings(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mobileBottomNavigationBar(BuildContext context) {
    return ResponsibleBuilder(
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
                    ? CustomAppThemes.menuSelectedTextStyle
                    : CustomAppThemes.menuNormalTextStyle,
              ),
            );
          }).toList(),
        ),
      ),
      desktopWidget: null,
    );
  }
}
