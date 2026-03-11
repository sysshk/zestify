import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/services/living_cleaning_screen.dart';
import '../screens/services/moving_cleaning_screen.dart';
import '../screens/booking/booking_screen.dart';
import '../screens/booking/booking_complete_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/support/customer_support_screen.dart';
import '../screens/support/partner_support_screen.dart';
import '../models/service_type.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final authProvider = context.read<AuthProvider>();
    final isLoggedIn = authProvider.isLoggedIn;
    final isBookingRoute = state.matchedLocation.startsWith('/booking');

    if (isBookingRoute && !isLoggedIn) {
      return '/login?redirect=${state.matchedLocation}';
    }
    return null;
  },
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        final redirect = state.uri.queryParameters['redirect'];
        return NoTransitionPage(child: LoginScreen(redirectAfterLogin: redirect));
      },
    ),
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreen()),
    ),
    GoRoute(
      path: '/services/living',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: LivingCleaningScreen()),
    ),
    GoRoute(
      path: '/services/moving',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: MovingCleaningScreen()),
    ),
    GoRoute(
      path: '/support',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: CustomerSupportScreen()),
    ),
    GoRoute(
      path: '/partner',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: PartnerSupportScreen()),
    ),
    GoRoute(
      path: '/booking/complete',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: BookingCompleteScreen()),
    ),
    GoRoute(
      path: '/booking/:serviceType',
      pageBuilder: (context, state) {
        final type = state.pathParameters['serviceType'] ?? 'living';
        return NoTransitionPage(
          child: BookingScreen(serviceType: ServiceType.fromString(type)),
        );
      },
    ),
  ],
);
