import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const duration = Duration(seconds: 3);

/// 启动页
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Widget 挂载后立即开始计时跳转
    _navigate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// 延迟 3 秒后跳转到首页
  Future<void> _navigate() async {
    _timer = Timer(duration, () {
      // 使用 mounted 检查避免 Widget 已销毁时操作 context 导致异常
      if (mounted) {
        context.goNamed("home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // StackFit.expand：所有子组件撑满整个 Stack 区域
        fit: StackFit.expand,
        children: [
          // 第一层：全屏背景风景图
          Image.asset('assets/images/splash.png', fit: BoxFit.cover),

          // 第二层：顶部品牌标题 "Aspen"
          // SafeArea 确保内容不被状态栏（顶部刘海/灵动岛）遮挡
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, left: 48, right: 48),
              child: FittedBox(
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
                child: Text(
                  "Aspen",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Hiatus",
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),

          // 第三层：底部 Slogan 文字 + "Explore" 跳转按钮
          // Positioned 将该层固定在 Stack 底部，精确控制位置
          Positioned(
            bottom: 52,
            left: 32,
            right: 32,
            child: Column(
              // 文字和按钮均靠左对齐
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Plan your",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    height: 1.2,
                  ),
                ),
                Text(
                  "Luxurious",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    height: 1.2,
                  ),
                ),
                Text(
                  "Vacation",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  // double.infinity 让按钮宽度撑满父容器（即 Positioned 的可用宽度）
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [Color(0xFF176FF2), Color(0xFF196EEE)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // 用户主动点击时，取消自动跳转计时器，避免重复跳转
                      _timer?.cancel();
                      context.goNamed("home");
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
