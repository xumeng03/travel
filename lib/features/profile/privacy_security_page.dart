import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/common/models/ToggleData.dart';
import 'package:travel/common/models/ActionMenuData.dart';
import 'package:travel/common/models/PrivacyMenuData.dart';
import 'package:travel/common/widgets/Toggle.dart';

const _blue = Color(0xFF176FF2);
const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);

class PrivacySecurityPage extends StatefulWidget {
  const PrivacySecurityPage({super.key});

  @override
  State<PrivacySecurityPage> createState() => _PrivacySecurityPageState();
}

class _PrivacySecurityPageState extends State<PrivacySecurityPage> {
  /// 隐私开关列表（实际项目中数据来自 API）
  final List<PrivacyMenuData> _toggleItems = [
    PrivacyMenuData(
      title: 'Profile Visibility',
      subtitle: 'Make your profile visible to others',
      toggleData: ToggleData(isOn: true),
    ),
    PrivacyMenuData(
      title: 'Activity Status',
      subtitle: "Show when you're active",
      toggleData: ToggleData(isOn: false),
    ),
    PrivacyMenuData(
      title: 'Location Sharing',
      subtitle: 'Share your location',
      toggleData: ToggleData(isOn: true),
    ),
  ];

  /// 操作入口列表（纯展示，无状态，使用 const）
  static const _actionItems = [
    ActionMenuData(icon: Icons.lock_outline, label: 'Change Password'),
    ActionMenuData(icon: Icons.remove_red_eye_outlined, label: 'Privacy Policy'),
    ActionMenuData(icon: Icons.shield_outlined, label: 'Terms of Service'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildToggleSection(),
            const SizedBox(height: 24),
            _buildActionSection(),
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
          'Privacy & Security',
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

  /// 构建隐私开关区块
  Widget _buildToggleSection() {
    return Column(
      children: [
        for (final item in _toggleItems)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildToggleItem(item),
          ),
      ],
    );
  }

  /// 构建单个开关项
  /// 白色圆角卡片，左侧标题+副标题，右侧自定义 Toggle
  Widget _buildToggleItem(PrivacyMenuData item) {
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
          Toggle(toggleData: item.toggleData),
        ],
      ),
    );
  }

  /// 构建操作入口区块（Change Password / Privacy Policy / Terms of Service）
  Widget _buildActionSection() {
    return Column(
      children: [
        for (final item in _actionItems)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildActionMenuData(item),
          ),
      ],
    );
  }

  /// 构建单个操作入口项
  /// 白色圆角卡片，左侧蓝色图标盒子 + 标签文字
  Widget _buildActionMenuData(ActionMenuData item) {
    return Container(
      height: 76,
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
          // 蓝色渐变图标盒子（10% 透明度）
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment(-0.87, -0.23),
                end: Alignment(1.02, 0.23),
                colors: [Color(0x1A176FF2), Color(0x1A196EEE)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, size: 20, color: _blue),
          ),
          const SizedBox(width: 16),
          Text(
            item.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _textDark,
            ),
          ),
        ],
      ),
    );
  }
}
