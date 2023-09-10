import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/modules/home/data/enums/home_page_menu.dart';
import '../../../../core/presentation/widgets/app_notification_widget.dart';

class HomeController extends GetxController {
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

  final Rx<DateTime?> _lastNotification = Rx<DateTime?>(null);
  final Rx<AppNotificationWidget?> _notification =
      Rx<AppNotificationWidget?>(null);
  AppNotificationWidget? get notification => _notification.value;

  Future<void> showNotification(AppNotificationWidget notification) async {
    _notification.value = null;
    await Future.delayed(const Duration(milliseconds: 100));

    final dateTime = DateTime.now();
    _notification.value = notification;
    _lastNotification.value = dateTime;

    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (_lastNotification.value != null &&
          dateTime.isAtSameMomentAs(_lastNotification.value!)) {
        _notification.value = null;
      }
    });
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }
}
