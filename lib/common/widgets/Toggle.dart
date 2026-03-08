import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/common/models/ToggleData.dart';

class Toggle extends StatefulWidget {
  Toggle({super.key, required this.toggleData});

  ToggleData toggleData;

  @override
  State<StatefulWidget> createState() {
    return _ToggleState();
  }
}

class _ToggleState extends State<Toggle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => widget.toggleData.isOn = !widget.toggleData.isOn),
      // AnimatedContainer 属性值发生变化时自动补间动画
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: 48,
        height: 24,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          gradient: widget.toggleData.isOn
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF176FF2), Color(0xFF196EEE)],
                )
              : const LinearGradient(colors: [Color(0xFFE7E9F3), Color(0xFFE7E9F3)]),
          borderRadius: BorderRadius.circular(999),
        ),
        // AnimatedAlign 属性值发生变化时自动补间动画
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 120),
          alignment: widget.toggleData.isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
