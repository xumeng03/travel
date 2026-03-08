import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _blue = Color(0xFF176FF2);
const _textLight = Color(0xFFB8B8B8);

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
                  _navItem(context, Icons.home_rounded, 0),
                  // 首页
                  _navItem(context, Icons.confirmation_number_outlined, 1),
                  // 票务
                  _navItem(context, Icons.favorite_border, 2),
                  // 收藏
                  _navItem(context, Icons.person_outline, 3),
                  // 个人
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _currentIndex(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    if (path.startsWith('/tickets'))      return 1;
    if (path.startsWith('/favorites'))    return 2;
    if (path.startsWith('/profile'))      return 3;
    if (path.startsWith('/personal_info')) return 3;
    return 0;
  }

  /// 构建单个导航项
  /// 选中时显示蓝色圆角背景 + 白色图标，未选中时显示灰色图标
  Widget _navItem(BuildContext context, IconData icon, int index) {
    // 当前项是否为选中状态
    final selected = index == _currentIndex(context);
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            context.goNamed('home');
            break;
          case 1:
            context.goNamed('tickets');
            break;
          case 2:
            context.goNamed('favorites');
            break;
          case 3:
            context.goNamed('profile');
            break;
          default:
            print("index ${index} not found!");
        }
      },
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
          icon,
          // 选中：白色图标；未选中：灰色图标
          color: selected ? Colors.white : _textLight,
          size: 24,
        ),
      ),
    );
  }
}
