import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/features/home/data/enums/home_page_menu.dart';
import 'package:simple_overlay/simple_overlay.dart';

class HomePageController extends GetxController {
  @override
  void onInit() {
    pageController.addListener(() {
      _currentPage.value =
          HomePageMenu.values[_pageController.page?.round() ?? 0];
    });
    super.onInit();
  }

  final Rx<HomePageMenu> _currentPage = Rx<HomePageMenu>(HomePageMenu.home);
  HomePageMenu get currentPage => _currentPage.value;
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  void changePage(HomePageMenu page) {
    pageController.animateToPage(
      HomePageMenu.values.indexOf(page),
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  final SimpleOverlayController _notificationBarController =
      SimpleOverlayController();
  SimpleOverlayController get notificationBarController =>
      _notificationBarController;

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }
}
