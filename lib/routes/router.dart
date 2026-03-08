import 'package:go_router/go_router.dart';
import 'package:travel/features/scenic_spot/scenic_spot_page.dart';
import 'package:travel/features/shell/bottom_nav.dart';
import 'package:travel/features/splash/splash_page.dart';

import '../features/error/not_found_page.dart';
import '../features/favorites/favorites_page.dart';
import '../features/home/home_page.dart';
import '../features/profile/profile_page.dart';
import '../features/tickets/tickets_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: "splash",
      builder: (context, state) => SplashPage(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BottomNav(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: "home",
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/tickets',
          name: "tickets",
          builder: (context, state) => const TicketsPage(),
        ),
        GoRoute(
          path: '/favorites',
          name: "favorites",
          builder: (context, state) => const FavoritesPage(),
        ),
        GoRoute(
          path: '/profile',
          name: "profile",
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/scenic_spot',
      name: "scenic_spot",
      builder: (context, state) => ScenicSpotPage(),
    ),
  ],
  errorBuilder: (context, state) => NotFoundpage(),
);
