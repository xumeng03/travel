import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/models/ToggleData.dart';
import '../../common/models/SettingsMenuData.dart';
import '../../common/widgets/Toggle.dart';

const _blue = Color(0xFF176FF2);
const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);
const _textLight = Color(0xFFB8B8B8);
const _redBg = Color(0xFFFEF2F2);

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  /// 语言选项列表
  static const _languages = ['English', 'Chinese'];

  /// 当前选中的语言
  String _selectedLanguage = 'English';

  /// 开关项数据：图标、标题、副标题
  final List<SettingsMenuData> _toggleItems = [
    SettingsMenuData(
      icon: Icons.dark_mode_outlined,
      title: 'Dark Mode',
      subtitle: 'Switch to dark theme',
      toggleData: ToggleData(isOn: false),
    ),
    SettingsMenuData(
      icon: Icons.download_outlined,
      title: 'Offline Mode',
      subtitle: 'Download maps and content',
      toggleData: ToggleData(isOn: false),
    ),
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
            _buildLanguageCard(),
            const SizedBox(height: 12),
            for (final item in _toggleItems)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildToggleItem(item),
              ),
            _buildClearCacheItem(),
          ],
        ),
      ),
    );
  }

  /// 构建顶部导航栏（返回按钮 + 页面标题）
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
          'App Settings',
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

  /// 构建语言选择卡片
  /// 顶部一行：蓝色图标盒 + 标题/副标题；下方为语言下拉选择器
  Widget _buildLanguageCard() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          // 标题行：图标 + 文字
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0x1A176FF2), Color(0x1A196EEE)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.language_outlined, size: 20, color: _blue),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Language',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Select your preferred language',
                      style: TextStyle(fontSize: 12, color: _textGray),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 语言下拉选择器
          _buildLanguageSelector(),
        ],
      ),
    );
  }

  /// 构建语言下拉选择器
  /// 5% 透明度蓝色渐变背景，圆角 12，右侧展开箭头
  Widget _buildLanguageSelector() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x0D176FF2), Color(0x0D196EEE)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedLanguage,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: _blue),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
          onChanged: (value) {
            if (value != null) setState(() => _selectedLanguage = value);
          },
          items: [
            for (final lang in _languages)
              DropdownMenuItem(value: lang, child: Text(lang)),
          ],
        ),
      ),
    );
  }

  /// 构建单个开关项（Dark Mode / Offline Mode）
  /// 白色圆角卡片，左侧蓝色图标盒 + 标题/副标题，右侧自定义 Toggle
  Widget _buildToggleItem(SettingsMenuData item) {
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
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0x1A176FF2), Color(0x1A196EEE)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, size: 20, color: _blue),
          ),
          const SizedBox(width: 16),
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

  /// 构建 Clear Cache 操作项
  /// 左侧红色背景 🗑️ 图标盒，右侧显示当前缓存大小"124 MB"
  Widget _buildClearCacheItem() {
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
          // 红色背景图标盒
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _redBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('🗑️', style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Clear Cache',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _textDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Free up storage space',
                  style: TextStyle(fontSize: 12, color: _textGray),
                ),
              ],
            ),
          ),
          // 右侧缓存大小文字
          const Text(
            '124 MB',
            style: TextStyle(fontSize: 13, color: _textLight),
          ),
        ],
      ),
    );
  }
}
