import 'package:go_router/go_router.dart';
import 'package:travel/features/splash/splash_page.dart';

import '../features/error/NotFoundPage.dart';
import '../features/home/home_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: "splash",
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: '/home',
      name: "home",
      builder: (context, state) => HomePage(),
    ),
  ],
  errorBuilder: (context, state) => NotFoundpage(),
);
