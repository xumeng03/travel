import 'package:flutter/material.dart';

class ProfileMenuData {
  final IconData icon;
  final String label;
  final Color color;

  /// 跳转的路由名，为 null 时表示该功能暂未实现，点击无响应
  final String? routeName;

  const ProfileMenuData({
    required this.icon,
    required this.label,
    required this.color,
    this.routeName,
  });
}