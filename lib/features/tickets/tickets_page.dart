import 'package:flutter/material.dart';

const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  final _tickets = [
    {
      'imageUrl': 'assets/images/explore_aspen.png',
      'title': 'Coeurdes Alpes',
      'location': 'Aspen, USA',
      'statusLabel': 'Upcoming',
      'statusColor': const Color(0xFF00C950),
      'date': '2026-03-15',
      'time': '14:00',
      'ticketNumber': 'ASP-2026-001',
    },
    {
      'imageUrl': 'assets/images/alley_palace.png',
      'title': 'Alley Palace',
      'location': 'Aspen, USA',
      'statusLabel': 'Confirmed',
      'statusColor': const Color(0xFF2B7FFF),
      'date': '2026-04-20',
      'time': '10:00',
      'ticketNumber': 'MAL-2026-102',
    },
    {
      'imageUrl': 'assets/images/alley_palace.png',
      'title': 'Alley Palace',
      'location': 'Aspen, USA',
      'statusLabel': 'Confirmed',
      'statusColor': const Color(0xFF2B7FFF),
      'date': '2026-04-20',
      'time': '10:00',
      'ticketNumber': 'MAL-2026-102',
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
              itemCount: _tickets.length,
              itemBuilder: (context, index) {
                final ticket = _tickets[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildTicketCard(ticket)
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 构建顶部标题栏
  /// 显示页面标题和当前有效票数
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tickets',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: _textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${_tickets.length} active tickets',
              style: const TextStyle(fontSize: 12, color: _textGray),
            ),
          ],
        ),
        // 右上角票务图标按钮
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.confirmation_number_outlined,
            color: Colors.blue,
            size: 24,
          ),
        ),
      ],
    );
  }

  /// 构建票务卡片
  /// 白色圆角卡片，蓝色阴影，由图片区和详情区两部分组成
  Widget _buildTicketCard(Map<String, Object> ticket) {
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
      child: Column(
        children: [_buildCardImage(ticket), _buildCardBody(ticket)],
      ),
    );
  }

  /// 构建卡片图片区域
  /// 高度 160px，底部渐变遮罩，左下角显示景点名和地址，右上角显示状态标签
  Widget _buildCardImage(Map<String, Object> ticket) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: Stack(
        children: [
          // 背景图片
          Positioned.fill(
            child: Image.asset(ticket['imageUrl'] as String, fit: BoxFit.cover),
          ),
          // 渐变遮罩层
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.6),
                  ],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
          ),
          // 左下角：景点名 + 地址
          Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket['title'] as String,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      ticket['location'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 右上角：状态标签
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: ticket['statusColor'] as Color,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                ticket['statusLabel'] as String,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建卡片详情区域
  /// 包含日期时间行、票号展示区（蓝色渐变背景）和查看二维码入口
  Widget _buildCardBody(Map<String, Object> ticket) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // 日期 + 时间行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: _textGray,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    ticket['date'] as String,
                    style: const TextStyle(fontSize: 12, color: _textGray),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_outlined,
                    size: 16,
                    color: _textGray,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    ticket['time'] as String,
                    style: const TextStyle(fontSize: 12, color: _textGray),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 票号区域（蓝色渐变背景）
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0x0D176FF2), Color(0x0D196EEE)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ticket Number',
                  style: TextStyle(fontSize: 10, color: _textGray),
                ),
                const SizedBox(height: 4),
                Text(
                  ticket['ticketNumber'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _textDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 查看二维码 + 箭头
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.qr_code, size: 18, color: _textDark),
                  const SizedBox(width: 8),
                  const Text(
                    'View QR',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _textDark,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, size: 20, color: _textGray),
            ],
          ),
        ],
      ),
    );
  }
}
