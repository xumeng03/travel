import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 颜色常量
const _blue = Color(0xFF176FF2);
const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);
const _textLight = Color(0xFFB8B8B8);
const _green = Color(0xFF2DD7A4);
const _darkGreen = Color(0xFF3A544F);

class ScenicSpotPage extends StatefulWidget {
  const ScenicSpotPage({super.key});

  @override
  State<ScenicSpotPage> createState() => _ScenicSpotPageState();
}

class _ScenicSpotPageState extends State<ScenicSpotPage> {
  // 收藏状态
  bool _isFavorite = true;

  // 设施数据
  final _facilities = [
    {'icon': Icons.wifi, 'label': '1 Heater'},
    {'icon': Icons.restaurant, 'label': 'Dinner'},
    {'icon': Icons.bathtub_outlined, 'label': '1 Tub'},
    {'icon': Icons.pool, 'label': 'Pool'},
    {'icon': Icons.wifi, 'label': '1 Heater'},
    {'icon': Icons.restaurant, 'label': 'Dinner'},
    {'icon': Icons.bathtub_outlined, 'label': '1 Tub'},
    {'icon': Icons.pool, 'label': 'Pool'},
    {'icon': Icons.wifi, 'label': '1 Heater'},
    {'icon': Icons.restaurant, 'label': 'Dinner'},
    {'icon': Icons.bathtub_outlined, 'label': '1 Tub'},
    {'icon': Icons.pool, 'label': 'Pool'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF0F8),
      body: SafeArea(
        child: Stack(
          children: [
            // 主内容区（可滚动）
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroImage(context),
                  _buildProductInfo(),
                  _buildFacilities(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            // 底部预订栏（固定）
            Positioned(left: 0, right: 0, bottom: 0, child: _buildBooking(context)),
          ],
        ),
      ),
    );
  }

  /// 构建顶部大图区域
  /// Stack 叠加：背景封面图 → 返回按钮（左上）→ 收藏按钮（右下）
  Widget _buildHeroImage(BuildContext context) {
    return SizedBox(
      height: 376,
      width: double.infinity,
      child: Stack(
        children: [
          // 封面图，圆角裁剪
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/coeurdes_alpes.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // 左上角返回按钮
          Positioned(
            top: 32,
            left: 32,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 16,
                  color: _textDark,
                ),
              ),
            ),
          ),
          // 右下角收藏按钮
          Positioned(
            bottom: 20,
            right: 44,
            child: GestureDetector(
              onTap: () => setState(() => _isFavorite = !_isFavorite),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0038FF).withValues(alpha: 0.1),
                      blurRadius: 19,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建景点信息区
  /// 包含：名称、评分、Show map、描述、Read more
  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 名称行 + Show map
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Coeurdes Alpes',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: _textDark,
                ),
              ),
              // Show map 渐变文字
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF176FF2), Color(0xFF196EEE)],
                ).createShader(bounds),
                child: const Text(
                  'Show map',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 评分行
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              const Text(
                '4.5 (355 Reviews)',
                style: TextStyle(fontSize: 12, color: _textGray),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 景点描述
          const Text(
            'Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining shopping and ....',
            style: TextStyle(fontSize: 14, color: _darkGreen, height: 1.5),
          ),
          const SizedBox(height: 8),
          // Read more 渐变文字 + 箭头
          Row(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF176FF2), Color(0xFF196EEE)],
                ).createShader(bounds),
                child: const Text(
                  'Read more',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 20, color: _blue),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// 构建设施区域
  /// 横向排列设施标签，每项包含图标和文字说明
  Widget _buildFacilities() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Facilities',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
          const SizedBox(height: 16),
          // 设施标签横向排列
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              // 主轴方向（垂直）的间距
              mainAxisSpacing: 16,
              // 交叉轴方向（横向）的间距
              crossAxisSpacing: 16,
              // 子项宽高比
              childAspectRatio: 1,
            ),
            itemCount: _facilities.length,
            itemBuilder: (context, index) {
              final facility = _facilities[index];
              return _buildFacilityItem(
                icon: facility['icon'] as IconData,
                label: facility['label'] as String,
              );
            },
          ),
        ],
      ),
    );
  }

  /// 构建单个设施标签
  /// 蓝色半透明渐变背景 + 图标 + 文字
  Widget _buildFacilityItem({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        // 蓝色半透明渐变背景
        gradient: const LinearGradient(
          colors: [Color(0x0D176FF2), Color(0x0D196EEE)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: _textLight),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 10, color: _textLight)),
        ],
      ),
    );
  }

  /// 构建底部预订栏
  /// 左侧价格，右侧 Book Now 按钮
  Widget _buildBooking(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        children: [
          // 左侧：价格
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Price', style: TextStyle(fontSize: 12, color: _textDark)),
              SizedBox(height: 2),
              Text(
                '\$199',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _green,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          // 右侧：Book Now 按钮（渐变背景）
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF176FF2), Color(0xFF196EEE)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0038FF).withValues(alpha: 0.24),
                    blurRadius: 19,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushNamed('booking_confirm');
                    },
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
