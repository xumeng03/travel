import 'package:go_router/go_router.dart';
import 'package:travel/features/booking/booking_confirm_page.dart';
import 'package:travel/features/tickets/ticket_detail_page.dart';
import 'package:travel/features/scenic_spot/scenic_spot_page.dart';
import 'package:travel/features/shell/bottom_nav.dart';
import 'package:travel/features/splash/splash_page.dart';

import '../features/error/not_found_page.dart';
import '../features/favorites/favorites_page.dart';
import '../features/home/home_page.dart';
import '../features/profile/app_settings_page.dart';
import '../features/profile/help_support_page.dart';
import '../features/profile/notifications_page.dart';
import '../features/profile/personal_info_page.dart';
import '../features/profile/privacy_security_page.dart';
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
        GoRoute(
          path: '/personal_info',
          name: "personal_info",
          builder: (context, state) => const PersonalInfoPage(),
        ),
        GoRoute(
          path: '/notifications',
          name: "notifications",
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: '/privacy_security',
          name: "privacy_security",
          builder: (context, state) => const PrivacySecurityPage(),
        ),
        GoRoute(
          path: '/app_settings',
          name: "app_settings",
          builder: (context, state) => const AppSettingsPage(),
        ),
        GoRoute(
          path: '/help_support',
          name: "help_support",
          builder: (context, state) => const HelpSupportPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/ticket_detail',
      name: "ticket_detail",
      builder: (context, state) => const TicketDetailPage(),
    ),
    GoRoute(
      path: '/booking_confirm',
      name: "booking_confirm",
      builder: (context, state) => const BookingConfirmPage(),
    ),
    GoRoute(
      path: '/scenic_spot',
      name: "scenic_spot",
      builder: (context, state) => ScenicSpotPage(),
    ),
  ],
  errorBuilder: (context, state) => NotFoundpage(),
);
