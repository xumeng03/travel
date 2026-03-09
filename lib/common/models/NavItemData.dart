import 'package:flutter/material.dart';

class NavItemData {
  /// 所属 tab 的下标（0=首页 1=票务 2=收藏 3=个人）
  final int index;

  /// 路由名，用于 context.goNamed() 跳转
  final String routeName;

  /// 路由路径，用于与当前 URL 做前缀匹配
  final String routePath;

  /// tab 图标；子页面无需显示图标，传 null
  final IconData? icon;

  const NavItemData({
    required this.index,
    required this.routeName,
    required this.routePath,
    this.icon,
  });
}