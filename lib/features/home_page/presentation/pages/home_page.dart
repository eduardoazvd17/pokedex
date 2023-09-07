import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/features/home_page/data/enums/home_page_menu.dart';

import '../../../../core/data/utils/app_icons.dart';
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
        Row(
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
      ],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Obx(
      () => Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: HomePageMenu.values
              .map(
                (item) => InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () => controller.changePage(item),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: item.icon(
                            isSelected: item == controller.currentPage,
                          ),
                        ),
                        Text(
                          item.label,
                          style: TextStyle(
                            color: item == controller.currentPage
                                ? Theme.of(context).primaryColor
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
