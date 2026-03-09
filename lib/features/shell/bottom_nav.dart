import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/common/models/NavItemData.dart';

const _blue = Color(0xFF176FF2);
const _textLight = Color(0xFFB8B8B8);

/// 所有路由与 tab 下标的映射表
/// 主导航项（icon != null）用于渲染底部图标；子页面仅用于路径匹配
const _navItems = [
  NavItemData(index: 0, routeName: 'home',             routePath: '/home',             icon: Icons.home_rounded),
  NavItemData(index: 1, routeName: 'tickets',          routePath: '/tickets',          icon: Icons.confirmation_number_outlined),
  NavItemData(index: 2, routeName: 'favorites',        routePath: '/favorites',        icon: Icons.favorite_border),
  NavItemData(index: 3, routeName: 'profile',          routePath: '/profile',          icon: Icons.person_outline),
  NavItemData(index: 3, routeName: 'personal_info',    routePath: '/personal_info'),
  NavItemData(index: 3, routeName: 'notifications',    routePath: '/notifications'),
  NavItemData(index: 3, routeName: 'privacy_security', routePath: '/privacy_security'),
  NavItemData(index: 3, routeName: 'app_settings',     routePath: '/app_settings'),
  NavItemData(index: 3, routeName: 'help_support',     routePath: '/help_support'),
];

/// 仅包含 icon 的主导航项，用于渲染底部导航栏图标
final _tabItems = _navItems.where((e) => e.icon != null).toList();

/// 构建底部导航栏
/// 固定在页面底部，包含四个导航项：首页、票务、收藏、个人
class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: child),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                // 白色到浅灰的渐变背景
                gradient: const LinearGradient(
                  colors: [Color(0xFFFEFEFE), Color(0xFFF5F5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                // 仅顶部两角圆角，与页面内容形成分隔
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                // 顶部蓝色微投影，增强悬浮感
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF186FF2).withValues(alpha: 0.05),
                    blurRadius: 22,
                    offset: const Offset(15, -19),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (final item in _tabItems)
                    _tabItem(context, item),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 从当前路径查找匹配的路由记录，返回其 tab 下标；未匹配时默认返回 0
  int _currentIndex(BuildContext context) {
    // GoRouterState.of(context).uri.path 读取当前 URL 路径，例如：
    final path = GoRouterState.of(context).uri.path;

    return _navItems
        // firstWhere：遍历 _navItems，返回第一个满足条件的元素
        .firstWhere(
          (e) => path.startsWith(e.routePath),
          // orElse：当所有记录都不匹配时的兜底回调，确保不会抛出 StateError
          orElse: () => _navItems.first,
        )
        // 取出匹配记录的 index 字段，即该路由所属的 tab 下标
        .index;
  }

  /// 构建单个导航项
  /// 选中时显示蓝色圆角背景 + 白色图标，未选中时显示灰色图标
  Widget _tabItem(BuildContext context, NavItemData item) {
    final selected = item.index == _currentIndex(context);
    return GestureDetector(
      onTap: () => context.goNamed(item.routeName),
      child: Container(
        width: 48,
        height: 48,
        // 选中：蓝色圆角背景；未选中：无背景
        decoration: selected
            ? BoxDecoration(
                color: _blue,
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Icon(
          item.icon,
          // 选中：白色图标；未选中：灰色图标
          color: selected ? Colors.white : _textLight,
          size: 24,
        ),
      ),
    );
  }
}