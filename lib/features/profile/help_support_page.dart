import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/common/models/contact_item.dart';
import 'package:travel/common/models/faq_item.dart';

const _blue = Color(0xFF176FF2);
const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  /// 联系方式列表
  static const _contactItems = [
    ContactItem(
      icon: Icons.chat_bubble_outline,
      title: 'Live Chat',
      subtitle: 'Chat with our support team',
    ),
    ContactItem(
      icon: Icons.mail_outline,
      title: 'Email Support',
      subtitle: 'support@aspen.com',
    ),
    ContactItem(
      icon: Icons.phone_outlined,
      title: 'Phone Support',
      subtitle: '+1 (800) 123-4567',
    ),
  ];

  /// FAQ 问题列表
  static const _faqItems = [
    FaqItem(question: 'How do I book a trip?', category: 'Booking'),
    FaqItem(question: 'Can I cancel my reservation?', category: 'Cancellation'),
    FaqItem(
      question: 'What payment methods are accepted?',
      category: 'Payment',
    ),
    FaqItem(question: 'How do I change my booking?', category: 'Booking'),
    FaqItem(question: 'What is the refund policy?', category: 'Refund'),
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
            _buildSectionTitle('Contact Us'),
            const SizedBox(height: 16),
            _buildContactSection(),
            const SizedBox(height: 24),
            _buildSectionTitle('Frequently Asked Questions'),
            const SizedBox(height: 16),
            _buildFaqSection(),
            const SizedBox(height: 24),
            _buildFooter(),
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
          'Help & Support',
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

  /// 构建区块标题（Contact Us / Frequently Asked Questions）
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _textDark,
      ),
    );
  }

  /// 构建联系方式区块
  /// 每项：左侧蓝色 10% 图标盒 + 标题/副标题 + 右箭头
  Widget _buildContactSection() {
    return Column(
      children: [
        for (final item in _contactItems)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildContactItem(item),
          ),
      ],
    );
  }

  /// 构建单个联系方式项（白色圆角卡片）
  Widget _buildContactItem(ContactItem item) {
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
          // 蓝色 10% 透明度图标盒
          _buildIconBox(item.icon, opacity: 0.10),
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
          const Icon(Icons.chevron_right, size: 20, color: _textGray),
        ],
      ),
    );
  }

  /// 构建 FAQ 区块
  Widget _buildFaqSection() {
    return Column(
      children: [
        for (final item in _faqItems)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildFaqItem(item),
          ),
      ],
    );
  }

  /// 构建单个 FAQ 项（白色圆角卡片）
  /// 左侧蓝色 5% 图标盒（FileText 样式）+ 问题标题/分类标签 + 右箭头
  Widget _buildFaqItem(FaqItem item) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 蓝色 5% 透明度图标盒
          _buildIconBox(Icons.article_outlined, opacity: 0.05),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.question,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.category,
                  style: const TextStyle(fontSize: 12, color: _textGray),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, size: 20, color: _textGray),
        ],
      ),
    );
  }

  /// 构建底部"Need more help?"区域
  /// 两行文字：灰色说明 + 蓝色渐变加粗链接
  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          const Text(
            'Need more help?',
            style: TextStyle(fontSize: 14, color: _textGray),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Visit Help Center',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A0A0A),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 构建蓝色渐变图标盒（44×44，圆角 12）
  /// [opacity] 控制渐变透明度：联系方式用 0.10，FAQ 用 0.05
  Widget _buildIconBox(IconData icon, {required double opacity}) {
    final alphaHex = (opacity * 255).round();
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.87, -0.23),
          end: const Alignment(1.02, 0.23),
          colors: [
            Color.fromARGB(alphaHex, 0x17, 0x6F, 0xF2),
            Color.fromARGB(alphaHex, 0x19, 0x6E, 0xEE),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 20, color: _blue),
    );
  }
}
