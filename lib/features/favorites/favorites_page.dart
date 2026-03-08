import 'package:flutter/material.dart';

const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);
const _mint = Color(0xFF2DD7A4);
const _red = Color(0xFFEC5655);
const _divider = Color(0xFFE7E9F3);

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _favorites = <Map<String, Object>>[
    {
      'imageUrl': 'assets/images/explore_aspen.png',
      'title': 'Coeurdes Alpes',
      'location': 'Aspen, USA',
      'rating': 4.5,
      'price': '\$199',
    },
    {
      'imageUrl': 'assets/images/alley_palace.png',
      'title': 'Alley Palace',
      'location': 'Aspen, USA',
      'rating': 4.1,
      'price': '\$149',
    },
    {
      'imageUrl': 'assets/images/alley_palace.png',
      'title': 'Alley Palace',
      'location': 'Aspen, USA',
      'rating': 4.1,
      'price': '\$149',
    },
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
            _buildHeader(),
            const SizedBox(height: 32),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final favorite = _favorites[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildCard(favorite),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 构建顶部标题栏
  /// 显示页面标题、已保存数量，以及右侧爱心图标按钮
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Favorites',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: _textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${_favorites.length} saved destinations',
              style: const TextStyle(fontSize: 12, color: _textGray),
            ),
          ],
        ),
        // 右上角爱心按钮
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFEC5655).withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.favorite, color: _red, size: 24),
        ),
      ],
    );
  }

  /// 构建收藏卡片
  /// 白色圆角卡片，蓝色阴影，由图片区和详情区两部分组成
  Widget _buildCard(Map<String, Object> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0038FF).withValues(alpha: 0.10),
            blurRadius: 19,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(children: [_buildCardImage(item), _buildCardBody(item)]),
    );
  }

  /// 构建卡片图片区域
  /// 高度 192px，底部渐变遮罩，右上角显示白色胶囊评分徽标
  Widget _buildCardImage(Map<String, Object> item) {
    final rating = item['rating'] as double;
    return SizedBox(
      height: 192,
      width: double.infinity,
      child: Stack(
        children: [
          // 背景图
          Positioned.fill(
            child: Image.asset(item['imageUrl'] as String, fit: BoxFit.cover),
          ),
          // 右上角评分徽标
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 10),
              height: 26,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: Color(0xFFF5A623),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _textGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建卡片详情区域
  /// 包含景点名称、地址，以及底部分隔线后的起始价格和移除按钮
  Widget _buildCardBody(Map<String, Object> item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          // 名称 + 地址
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['title'] as String,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _textDark,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: _textGray,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item['location'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _textGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 分隔线 + 价格 + 删除按钮
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: _divider, width: 0.8)),
            ),
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 价格
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Starting from',
                      style: TextStyle(fontSize: 10, color: _textGray),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['price'] as String,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _mint,
                      ),
                    ),
                  ],
                ),
                // 删除按钮
                GestureDetector(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(Icons.delete_outline, size: 18, color: _red),
                      SizedBox(width: 6),
                      Text(
                        'Remove',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _red,
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
    );
  }
}
