import 'package:app_badge_plus/app_badge_plus.dart';

class AppBadgePlugin {
  static Future<bool> get isBadgeSupported {
    return AppBadgePlus.isSupported();
  }

  static updateBadgeCount(int count) async {
    if (!await isBadgeSupported) {
      return;
    }

    AppBadgePlus.updateBadge(count);

    if (count == 0) removeBadge();
  }

  static void removeBadge() async {
    if (!await isBadgeSupported) {
      return;
    }

    AppBadgePlus.updateBadge(0);
  }
}
