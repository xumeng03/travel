import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _blue = Color(0xFF176FF2);
const _textDark = Color(0xFF232323);
const _textGray = Color(0xFF606060);

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _firstNameController = TextEditingController(text: 'John');
  final _lastNameController = TextEditingController(text: 'Doe');
  final _emailController = TextEditingController(text: 'john.doe@email.com');
  final _phoneController = TextEditingController(text: '+1 234 567 8900');
  final _dobController = TextEditingController(text: '2000-01-01');
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

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
            _buildAvatar(),
            const SizedBox(height: 32),
            _buildFormCard(),
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
        // 返回按钮
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
          'Personal Info',
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

  /// 构建居中头像区域
  /// 蓝色圆形渐变背景 + JD 文字 + 右下角相机按钮
  Widget _buildAvatar() {
    return Center(
      child: SizedBox(
        width: 96,
        height: 96,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 主头像
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF176FF2), Color(0xFF196EEE)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3D0038FF),
                    blurRadius: 19,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'JD',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // 右下角相机按钮
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('📷', style: TextStyle(fontSize: 14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建表单卡片
  /// 白色圆角卡片，包含所有输入字段和保存按钮
  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
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
          _buildField(
            label: 'First Name',
            controller: _firstNameController,
            icon: Icons.person_outline,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 20),
          _buildField(
            label: 'Last Name',
            controller: _lastNameController,
            icon: Icons.person_outline,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 20),
          _buildField(
            label: 'Email',
            controller: _emailController,
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _buildField(
            label: 'Phone Number',
            controller: _phoneController,
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          _buildField(
            label: 'Date of Birth',
            controller: _dobController,
            icon: Icons.calendar_today_outlined,
            readOnly: true,
            onTap: () => _pickDate(context),
          ),
          const SizedBox(height: 20),
          _buildField(
            label: 'Address',
            controller: _addressController,
            icon: Icons.location_on_outlined,
            maxLines: 3,
            keyboardType: TextInputType.streetAddress,
          ),
          const SizedBox(height: 24),
          _buildSaveButton(),
        ],
      ),
    );
  }

  /// 构建带图标的输入字段
  /// 蓝色渐变浅色背景，左侧图标，圆角 16
  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    int maxLines = 1,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: _textGray),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          keyboardType: keyboardType,
          onTap: onTap,
          style: const TextStyle(fontSize: 14, color: _textDark),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0x0D196EEE),
            prefixIcon: Icon(icon, size: 20, color: _textGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: _blue, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  /// 构建保存按钮
  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
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
      child: TextButton(
        onPressed: _onSave,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// 弹出系统日期选择器，用户选择后将日期写入出生日期输入框
  ///
  /// [showDatePicker] 是 Flutter 内置函数，会弹出一个 Material 风格的日历弹窗。
  /// 返回值是 Future<DateTime?>：用户确认返回所选日期，点取消返回 null。
  /// 使用 await 等待用户操作完成后再继续执行。
  ///
  /// [initialDate]  打开弹窗时默认显示的日期，与输入框默认值保持一致
  /// [firstDate]    日历可选的最早日期，限制为 2000 年 1 月 1 日
  /// [lastDate]     日历可选的最晚日期，限制为今天（不能选未来日期）
  ///
  /// [builder] 用于覆盖弹窗的 Theme，将日历的主色调改为项目蓝色 [_blue]，
  /// 否则会沿用系统默认的紫色。Theme.of(context).copyWith() 只替换
  /// colorScheme 一项，其余样式保持系统默认。child! 表示 child 一定不为
  /// null（Flutter 框架保证传入），用 ! 断言解包。
  ///
  /// 用户选择日期后，将 DateTime 格式化为 "YYYY-MM-DD" 字符串：
  /// padLeft(2, '0') 确保月份和日期不足两位时补零，例如 3 → "03"
  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: _blue),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      // 格式化为 YYYY-MM-DD，月份和日期不足两位时用 '0' 补齐
      _dobController.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  /// 保存表单数据
  void _onSave() {
    print("TODO: 调用 API 提交表单数据");
  }
}