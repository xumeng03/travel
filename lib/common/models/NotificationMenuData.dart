import 'package:travel/common/models/ToggleData.dart';

class NotificationMenuData {
  final String title;
  final String subtitle;
  final ToggleData toggleData;

  NotificationMenuData({
    required this.title,
    required this.subtitle,
    required this.toggleData,
  });
}