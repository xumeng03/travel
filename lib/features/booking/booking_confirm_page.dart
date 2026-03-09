import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _blue = Color(0xFF176FF2);
const _mint = Color(0xFF2DD7A4);
const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);
const _textLight = Color(0xFFB8B8B8);
const _divider = Color(0xFFE7E9F3);

class BookingConfirmPage extends StatelessWidget {
  const BookingConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE7E9F3), Color(0xFFFFFFFF)],
            stops: [0.16, 0.86],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 32),
                      _buildSpotCard(),
                      const SizedBox(height: 16),
                      _buildBookingDetailsCard(),
                      const SizedBox(height: 16),
                      _buildPriceDetailsCard(),
                      const SizedBox(height: 16),
                      _buildCancellationNote(),
                    ],
                  ),
                ),
              ),
              _buildPayment(),
            ],
          ),
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
              color: const Color(0xFFF3F8FE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.chevron_left,
              size: 20,
              color: _textDark,
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'Confirm Booking',
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

  /// 构建景点信息卡片（图片 + 名称 + 地点 + 价格）
  Widget _buildSpotCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0038FF).withValues(alpha: 0.10),
            blurRadius: 19,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // 景点图片
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/alley_palace.png',
              width: 96,
              height: 96,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // 名称、地点、价格
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Coeurdes Alpes',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Aspen, USA',
                  style: TextStyle(fontSize: 12, color: _textGray),
                ),
                const SizedBox(height: 10),
                // 价格：$199 绿色粗体 + /night 灰色小字
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '\$199',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _mint,
                        ),
                      ),
                      TextSpan(
                        text: '/night',
                        style: TextStyle(
                          fontSize: 12,
                          color: _textGray,
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

  /// 构建预订详情卡片（Check-in / Check-out / Duration / Guests）
  Widget _buildBookingDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0038FF).withValues(alpha: 0.10),
            blurRadius: 19,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Details',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            icon: Icons.calendar_today_outlined,
            // 蓝色：#176FF2 10% 透明
            iconBgColor: const Color(0x1A176FF2),
            iconColor: _blue,
            label: 'Check-in',
            value: 'Mar 15, 2026',
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            icon: Icons.calendar_today_outlined,
            // 绿色：#2DD7A4 10% 透明
            iconBgColor: const Color(0x1A2DD7A4),
            iconColor: _mint,
            label: 'Check-out',
            value: 'Mar 20, 2026',
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            icon: Icons.access_time_outlined,
            // 橙色：#DF9652 10% 透明
            iconBgColor: const Color(0x1ADF9652),
            iconColor: const Color(0xFFDF9652),
            label: 'Duration',
            value: '5 nights',
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            icon: Icons.people_outline,
            // 红色：#EC5655 10% 透明
            iconBgColor: const Color(0x1AEC5655),
            iconColor: const Color(0xFFEC5655),
            label: 'Guests',
            value: '2 adults',
          ),
        ],
      ),
    );
  }

  /// 构建单行详情项（彩色图标盒 + label/value）
  Widget _buildDetailRow({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        // 彩色渐变图标盒（48×48，圆角 12）
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: _textLight),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _textDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 构建价格明细卡片（费用明细 + 分隔线 + 总计）
  Widget _buildPriceDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0038FF).withValues(alpha: 0.10),
            blurRadius: 19,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price Details',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
          const SizedBox(height: 16),
          _buildPriceRow(label: '\$199 × 5 nights', value: '\$995'),
          const SizedBox(height: 12),
          _buildPriceRow(label: 'Service fee', value: '\$25'),
          const SizedBox(height: 12),
          _buildPriceRow(label: 'Tax (10%)', value: '\$100'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: _divider, thickness: 0.8),
          ),
          // 总计行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
              const Text(
                '\$1120',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _mint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建单行价格项（label 左对齐，value 右对齐）
  Widget _buildPriceRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: _textGray)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _textDark,
          ),
        ),
      ],
    );
  }

  /// 构建免费取消提示横幅（黄色背景警告框）
  Widget _buildCancellationNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        border: Border.all(color: const Color(0xFFFFE7A3), width: 0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        '⚠️ Free cancellation within 48 hours. After that, cancellation fees may apply.',
        style: TextStyle(fontSize: 12, color: Color(0xFF8B7300), height: 1.5),
      ),
    );
  }

  /// 构建底部支付栏（总金额 + Proceed to Payment 按钮）
  Widget _buildPayment() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧总金额
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Total Amount',
                style: TextStyle(fontSize: 12, color: _textGray),
              ),
              SizedBox(height: 4),
              Text(
                '\$1120',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _mint,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          // 右侧支付按钮
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
                    color: _blue.withValues(alpha: 0.24),
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
                      print('TODO: 跳转支付页面');
                    },
                    child: const Text(
                      'Proceed to Payment',
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