import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:simple_overlay/simple_overlay.dart';

import '../../data/utils/custom_app_icons.dart';
import '../widgets/app_notification_widget.dart';

class NotificationsController extends GetxController {
  final SimpleOverlayController addedToFavoritesNotificationController =
      SimpleOverlayController();
  final SimpleOverlayController removedFromFavoritesNotificaitonController =
      SimpleOverlayController();

  Widget notificationWidget(Widget child) {
    return SimpleOverlayWidget(
      controller: addedToFavoritesNotificationController,
      position: SimpleOverlayPosition.bottomLeft(left: -40),
      overlayWidget: AppNotificationWidget(
        icon: CustomAppIcons.heart(isSelected: true),
        text: 'added-to-favorite'.i18n(),
      ),
      configuration: SimpleOverlayConfiguration(
        hideOnTapOutside: true,
        autoHideDuration: const Duration(seconds: 2),
      ),
      child: SimpleOverlayWidget(
        controller: removedFromFavoritesNotificaitonController,
        position: SimpleOverlayPosition.bottomLeft(left: -40),
        overlayWidget: AppNotificationWidget(
          icon: CustomAppIcons.heart(),
          text: 'removed-from-favorite'.i18n(),
        ),
        configuration: SimpleOverlayConfiguration(
          hideOnTapOutside: true,
          autoHideDuration: const Duration(seconds: 2),
        ),
        child: child,
      ),
    );
  }
}
