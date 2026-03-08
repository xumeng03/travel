import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/common/widgets/Toggle.dart';

import '../../common/models/ToggleData.dart';

const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  /// 通知开关列表（实际项目中数据来自 API）
  final List<ToggleData> _items = [
    ToggleData(
      title: 'Push Notifications',
      subtitle: 'Receive push notifications',
      isOn: true,
    ),
    ToggleData(
      title: 'Promotions & Offers',
      subtitle: 'Get special offers and deals',
      isOn: false,
    ),
    ToggleData(
      title: 'Booking Updates',
      subtitle: 'Updates about your bookings',
      isOn: true,
    ),
    ToggleData(
      title: 'Favorite Updates',
      subtitle: 'Price drops on favorites',
      isOn: true,
    ),
    ToggleData(
      title: 'Newsletter',
      subtitle: 'Travel tips and guides',
      isOn: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildList(),
          ],
        ),
      ),
    );
  }

  /// 构建顶部导航栏
  /// 左侧返回按钮 + 页面标题
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: _textDark,
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
      ],
    );
  }

  /// 构建通知开关列表
  Widget _buildList() {
    return Column(
      children: [
        for (final item in _items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildItem(item),
          ),
      ],
    );
  }

  /// 构建单个通知开关项
  /// 白色圆角卡片，左侧标题+副标题，右侧自定义 Toggle
  Widget _buildItem(ToggleData item) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0038FF).withValues(alpha: 0.05),
            blurRadius: 19,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // 标题 + 副标题
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: const TextStyle(fontSize: 12, color: _textGray),
                ),
              ],
            ),
          ),
          // 自定义 Toggle
          Toggle(toggleData: item),
        ],
      ),
    );
  }
}
