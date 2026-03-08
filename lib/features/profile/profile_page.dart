import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/common/models/ProfileMenuData.dart';

const _blue = Color(0xFF176FF2);
const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);
const _textLight = Color(0xFFB8B8B8);
const _mint = Color(0xFF2DD7A4);
const _orange = Color(0xFFDF9652);
const _red = Color(0xFFEC5655);

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  /// 菜单项数据列表
  static const _profileMenuData = [
    ProfileMenuData(icon: Icons.person_outline,        label: 'Personal Info',      color: _blue,     routeName: 'personal_info'),
    ProfileMenuData(icon: Icons.notifications_outlined,label: 'Notifications',      color: _orange,   routeName: 'notifications'),
    ProfileMenuData(icon: Icons.lock_outline,          label: 'Privacy & Security', color: _blue,     routeName: 'privacy_security'),
    ProfileMenuData(icon: Icons.settings_outlined,     label: 'App Settings',       color: _textGray, routeName: 'app_settings'),
    ProfileMenuData(icon: Icons.help_outline,          label: 'Help & Support',     color: _red,      routeName: 'help_support'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileCard(),
            const SizedBox(height: 24),
            _buildMenuList(context),
            const SizedBox(height: 24),
            _buildLogoutButton(),
            const SizedBox(height: 20),
            _buildVersionText(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// 构建用户信息卡片
  /// 包含头像、基本信息、三栏统计数据和会员状态行
  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0038FF).withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // 右上角装饰色块（5% 透明度蓝色）
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF176FF2), Color(0xFF196EEE)],
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(192),
                ),
              ),
              foregroundDecoration: const BoxDecoration(
                color: Color(0xF2FFFFFF), // ~95% 白色遮罩使其变为 5% 透明度
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildUserInfo(),
                const SizedBox(height: 24),
                _buildStatsRow(),
                const SizedBox(height: 12),
                _buildMemberRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建头像 + 姓名 + 地址 + 邮箱行
  Widget _buildUserInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 头像区域
        SizedBox(
          width: 96,
          height: 96,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 主头像
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF176FF2), Color(0xFF196EEE)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0038FF).withValues(alpha: 0.30),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'JD',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // 右下角编辑按钮
              Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0038FF).withValues(alpha: 0.20),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.edit_outlined, size: 16, color: _blue),
                ),
              ),
              // 左上角绿点（在线状态）
              Positioned(
                left: -4,
                top: -4,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _mint.withValues(alpha: 0.30),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_mint, Color(0xFF25C796)],
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // 姓名、地址、邮箱
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'John Doe',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Icon(Icons.location_on_outlined, size: 12, color: _textGray),
                  SizedBox(width: 4),
                  Text(
                    'Aspen, Colorado',
                    style: TextStyle(fontSize: 12, color: _textGray),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'john.doe@email.com',
                style: TextStyle(fontSize: 11, color: _textLight),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建三栏统计数据（旅行次数、平均评分、积分）
  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatBox('12', 'Total Trips', const Color(0xFF176FF2), Icons.location_on_outlined),
        const SizedBox(width: 12),
        _buildStatBox('4.8', 'Avg Rating', _orange, Icons.emoji_events_outlined),
        const SizedBox(width: 12),
        _buildStatBox('2.4K', 'Points', _mint, Icons.trending_up),
      ],
    );
  }

  /// 构建单个统计方块
  Widget _buildStatBox(String value, String label, Color color, IconData icon) {
    return Expanded(
      child: Container(
        height: 87,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // 背景装饰图标（20% 透明度）
            Positioned(
              right: 0,
              top: 0,
              child: Icon(icon, size: 40, color: color.withValues(alpha: 0.20)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: _textGray),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建会员状态行（Gold Member + VIP 徽标）
  Widget _buildMemberRow() {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x0D176FF2), Color(0x0D2DD7A4)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // 蓝色圆形 Award 图标
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF176FF2), Color(0xFF196EEE)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.emoji_events_outlined, size: 20, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Gold Member',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _textDark,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Member since March 2024',
                    style: TextStyle(fontSize: 10, color: _textGray),
                  ),
                ],
              ),
            ],
          ),
          // VIP 徽标
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFDF9652), Color(0xFFCF8A46)],
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'VIP',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建设置菜单列表
  Widget _buildMenuList(BuildContext context) {
    return Column(
      children: [
        for (final menu in _profileMenuData)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildMenu(context, menu),
          ),
      ],
    );
  }

  /// 构建单个菜单项
  /// 左侧彩色图标 + 标签文字，右侧箭头；routeName 不为 null 时可点击跳转
  Widget _buildMenu(BuildContext context, ProfileMenuData menu) {
    return GestureDetector(
      onTap: menu.routeName != null ? () => context.pushNamed(menu.routeName!) : null,
      child: Container(
        height: 88,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0038FF).withValues(alpha: 0.08),
              blurRadius: 19,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // 彩色图标盒子
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: menu.color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(menu.icon, size: 22, color: menu.color),
            ),
            const SizedBox(width: 16),
            // 标签
            Expanded(
              child: Text(
                menu.label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: _textGray),
          ],
        ),
      ),
    );
  }

  /// 构建退出登录按钮
  Widget _buildLogoutButton() {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEC5655), Color(0xFFDC4B4A)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _red.withValues(alpha: 0.15),
            blurRadius: 19,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout_outlined, size: 20, color: Colors.white),
          SizedBox(width: 12),
          Text(
            'Logout',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建底部版本号文字
  Widget _buildVersionText() {
    return const Center(
      child: Text(
        'Aspen Travel App v1.0.0',
        style: TextStyle(fontSize: 12, color: _textLight),
      ),
    );
  }
}