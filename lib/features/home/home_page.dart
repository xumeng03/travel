import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _blue = Color(0xFF176FF2);
const _darkGreen = Color(0xFF3A544F);
const _cardGreen = Color(0xFF4D5652);
const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);
const _textLight = Color(0xFFB8B8B8);
const _searchBg = Color(0xFFF3F8FE);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategory = 0;
  int _selectedNav = 0;

  final _categories = ['Location', 'Hotels', 'Food', 'Adventure'];

  final _recommendedCards = [
    {'imageUrl': 'assets/images/explore_aspen.png', 'title': 'Explore Aspen'},
    {
      'imageUrl': 'assets/images/luxurious_aspen.jpg',
      'title': 'Luxurious Aspen',
    },
    {'imageUrl': 'assets/images/explore_aspen.png', 'title': 'Explore Aspen'},
    {
      'imageUrl': 'assets/images/luxurious_aspen.jpg',
      'title': 'Luxurious Aspen',
    },
    {'imageUrl': 'assets/images/explore_aspen.png', 'title': 'Explore Aspen'},
    {
      'imageUrl': 'assets/images/luxurious_aspen.jpg',
      'title': 'Luxurious Aspen',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  _buildCategories(),
                  const SizedBox(height: 24),
                  _buildPopular(),
                  const SizedBox(height: 24),
                  _buildRecommended(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Align(alignment: Alignment.bottomCenter, child: _buildBottomNav()),
          ],
        ),
      ),
    );
  }

  /// 构建顶部标题栏
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 16, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧：页面副标题 + 城市大标题
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: _textDark,
                ),
              ),
              const Text(
                'Aspen',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: _textDark,
                ),
              ),
            ],
          ),
          // 右侧：位置选择器（收藏图标 + 地名 + 下拉箭头）
          Row(
            children: [
              const Icon(Icons.favorite_border, size: 16),
              const SizedBox(width: 4),
              const Text(
                'Aspen, USA',
                style: TextStyle(fontSize: 12, color: _textGray),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 16, color: _textGray),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建搜索栏
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _searchBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            // 搜索图标
            const Icon(Icons.search, color: _textLight, size: 20),
            const SizedBox(width: 8),
            // 占位提示文字
            const Text(
              'Find things to do',
              style: TextStyle(fontSize: 13, color: _textLight),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建分类标签栏（横向可滚动）
  /// 点击标签切换 [_selectedCategory]，选中项高亮显示蓝色渐变背景
  Widget _buildCategories() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        // 每个标签之间的间距
        separatorBuilder: (_, _) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          // 当 index == _selectedCategory 时，selected 为 true
          final selected = index == _selectedCategory;
          return GestureDetector(
            // 点击更新选中状态
            onTap: () => setState(() => _selectedCategory = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              // 选中时显示蓝色渐变背景 + 圆角，未选中时无背景
              decoration: selected
                  ? BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0x0D176FF2), Color(0x0D196EEE)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(33),
                    )
                  : null,
              child: Text(
                _categories[index],
                style: TextStyle(
                  fontSize: 14,
                  // 选中：蓝色加粗；未选中：灰色正常
                  color: selected ? _blue : _textLight,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建通用区块标题行
  /// [title]：左侧主标题；[action]：右侧操作文字（传 null 则不显示）
  Widget _buildSection(String title, String? action) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧：区块标题
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
          // 右侧：操作按钮（如'See all'），action 为 null 时不渲染
          if (action != null)
            ShaderMask(
              // 用线性渐变着色，使文字呈现蓝色渐变效果
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF176FF2), Color(0xFF196EEE)],
              ).createShader(bounds),
              child: Text(
                action,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  // ShaderMask 要求子组件颜色为白色才能正确显示渐变
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 构建热门景点卡片列表（横向滚动）
  /// 使用 Stack 叠加：背景图 → 渐变蒙层 → 收藏按钮 → 底部信息
  Widget _buildPopular() {
    return Column(
      children: [
        _buildSection('Popular', 'See all'),
        const SizedBox(height: 16),
        Container(
          // 横向 ListView 必须有明确的高度约束才能渲染
          height: 240,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, _) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed('scenic_spot');
                },
                child: ClipRRect(
                  // 圆角裁剪整个卡片，所有子组件在圆角范围内渲染，超出部分直接丢弃
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      // 背景图片，加载失败时显示纯色兜底
                      SizedBox(
                        width: 188,
                        height: 240,
                        // 本地图片
                        child: Image.asset(
                          'assets/images/alley_palace.png',
                          fit: BoxFit.cover,
                        ),
                        // 网络图片
                        // child: Image.network(
                        //   _imgPopular,
                        //   fit: BoxFit.cover,
                        //   errorBuilder: (_, _, _) =>
                        //       Container(color: const Color(0xFF2A5A52)),
                        // ),
                      ),
                      // 从透明到深绿的渐变蒙层，使底部文字更易阅读
                      Positioned.fill(
                        // DecoratedBox 负责绘制装饰背景的轻量组件
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color(0xFF2A5A52).withValues(alpha: 0.85),
                              ],
                              // 60% 以上透明，60%~100% 渐变为深色
                              stops: const [0.6, 1.0],
                            ),
                          ),
                        ),
                      ),
                      // 右下角收藏按钮（圆形背景 + 红心图标）
                      Positioned(
                        bottom: 16,
                        right: 12,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: _searchBg,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                      ),
                      // 左下角信息区：景点名称标签 + 评分标签
                      Positioned(
                        bottom: 16,
                        left: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 景点名称胶囊标签
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _cardGreen,
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: const Text(
                                'Alley Palace',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            // 评分胶囊标签（星形图标 + 分值）
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _cardGreen,
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '4.1',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// 构建推荐卡片网格（2列）
  ///
  Widget _buildRecommended() {
    return Column(
      children: [
        _buildSection('Recommended', null),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            // 禁用 GridView 自身滚动，高度自动撑开，交由外层 SingleChildScrollView 统一滚动
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // 主轴方向（垂直）的间距
              mainAxisSpacing: 16,
              // 交叉轴方向（横向）的间距
              crossAxisSpacing: 16,
              // 子项宽高比
              childAspectRatio: 1,
            ),
            itemCount: _recommendedCards.length,
            itemBuilder: (context, index) {
              // 从数据列表中取出当前卡片数据
              final card = _recommendedCards[index];
              return _buildRecommendCard(
                imageUrl: card['imageUrl']!,
                title: card['title']!,
                duration: '4N/5D',
              );
            },
          ),
        ),
      ],
    );
  }

  /// 构建单张推荐卡片
  /// 结构：白色渐变卡片背景 → 上方图片区（含时长标签）→ 下方文字区（标题 + Hot Deal）
  Widget _buildRecommendCard({
    required String imageUrl,
    required String title,
    required String duration,
  }) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('scenic_spot');
      },
      child: Container(
        width: 174,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          // 白色到浅灰的渐变背景
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFF5F5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF4F4F4)),
          // 卡片底部阴影，增强层次感
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF97A0B2).withValues(alpha: 0.17),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 上方图片区：封面图 + 右下角时长标签
            Stack(
              children: [
                // 封面图，圆角裁剪，加载失败显示深绿色兜底
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 96,
                    // 本地图片
                    child: Image.asset(imageUrl, fit: BoxFit.cover),
                    // 网络图片
                    // child: Image.network(
                    //   imageUrl,
                    //   fit: BoxFit.cover,
                    //   errorBuilder: (_, __, ___) => Container(color: _darkGreen),
                    // ),
                  ),
                ),
                // 右下角时长标签（如 "4N/5D"），白色描边 + 深绿背景
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _darkGreen,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // 下方文字区：景点标题
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _textDark,
                    ),
                  ),
                  Text(
                    'Reloaded 1 of 847 libraries in 294ms',
                    style: const TextStyle(fontSize: 12, color: _textGray),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建底部导航栏
  /// 固定在页面底部，包含四个导航项：首页、票务、收藏、个人
  Widget _buildBottomNav() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        // 白色到浅灰的渐变背景
        gradient: const LinearGradient(
          colors: [Color(0xFFFEFEFE), Color(0xFFF5F5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // 仅顶部两角圆角，与页面内容形成分隔
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
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
          _navItem(Icons.home_rounded, 0), // 首页
          _navItem(Icons.confirmation_number_outlined, 1), // 票务
          _navItem(Icons.favorite_border, 2), // 收藏
          _navItem(Icons.person_outline, 3), // 个人
        ],
      ),
    );
  }

  /// 构建单个导航项
  /// 选中时显示蓝色圆角背景 + 白色图标，未选中时显示灰色图标
  Widget _navItem(IconData icon, int index) {
    // 当前项是否为选中状态
    final selected = index == _selectedNav;
    return GestureDetector(
      onTap: () => setState(() => _selectedNav = index),
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
