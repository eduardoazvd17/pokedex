import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/core/data/utils/custom_app_themes.dart';
import 'package:pokedex/features/home_page/data/enums/home_page_menu.dart';
import 'package:pokedex/features/home_page/presentation/widgets/pokemon_logo_widget.dart';

import '../../../../core/data/utils/custom_app_icons.dart';
import '../../../../core/presentation/widgets/custom_bottom_navigation_bar.dart';
import '../../../../core/presentation/widgets/custom_top_navigation_bar.dart';
import '../controllers/home_page_controller.dart';

class HomePage extends GetWidget<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _headerWidget,
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

  Widget get _headerWidget {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 768) {
        return _desktopHeader;
      } else {
        return _mobileHeader;
      }
    });
  }

  Widget get _mobileHeader {
    return Column(
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
    );
  }

  Widget get _desktopHeader {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        children: [
          const PokemonLogoWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
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
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: CustomAppIcons.settings(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Obx(() {
        return Visibility(
          visible: constraints.maxWidth < 768,
          child: CustomBottomNavigationBar(
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
        );
      });
    });
  }
}
