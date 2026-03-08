import 'package:flutter/material.dart';
import 'package:travel/routes/router.dart';

void main() {
  runApp(
    MaterialApp.router(
      title: 'Travel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    ),
  );
}
