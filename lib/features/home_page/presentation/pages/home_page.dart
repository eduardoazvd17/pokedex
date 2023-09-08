import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/core/data/utils/custom_app_themes.dart';
import 'package:pokedex/features/home_page/data/enums/home_page_menu.dart';

import '../../../../core/data/utils/custom_app_icons.dart';
import '../../../../core/presentation/widgets/custom_bottom_navigation_bar.dart';
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
              controller.notificationsController.notificationWidget(
                IconButton(
                  onPressed: () {},
                  icon: CustomAppIcons.notification(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Obx(() {
      return CustomBottomNavigationBar(
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
      );
    });
  }
}
