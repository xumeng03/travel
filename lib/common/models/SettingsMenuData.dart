import 'package:flutter/material.dart';
import 'package:travel/common/models/ToggleData.dart';

class SettingsMenuData {
  final IconData icon;
  final String title;
  final String subtitle;
  final ToggleData toggleData;

  SettingsMenuData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.toggleData,
  });
}