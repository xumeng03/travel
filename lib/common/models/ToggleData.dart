import 'package:flutter/cupertino.dart';

class ToggleData {
  final IconData? icon;
  final String title;
  final String subtitle;
  bool isOn;

  ToggleData({this.icon, required this.title, required this.subtitle, required this.isOn});
}
