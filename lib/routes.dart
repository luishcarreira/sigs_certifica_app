import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sigs_certifica_app/data/services/auth/api_auth_service.dart';
import 'package:sigs_certifica_app/locator.dart';
import 'package:sigs_certifica_app/presentation/views/auth/login_view.dart';
import 'package:sigs_certifica_app/presentation/views/home_view.dart';
import 'package:sigs_certifica_app/presentation/views/notification/notification_view.dart';
import 'package:sigs_certifica_app/presentation/views/splash_page.dart';
import 'package:sigs_certifica_app/widgets/auth_check.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/splash',
  redirect: (context, state) {
    final loggedIn = getIt<ApiAuthService>().isLogged();
    final isGoingToLogin = state.path == '/login';

    if (loggedIn && isGoingToLogin) return '/home';

    final isProtectedRoute = state.fullPath!.startsWith('/home') ||
        state.fullPath!.startsWith('/notifications');
    if (!loggedIn && isProtectedRoute) return '/login';

    return null;
  },
  routes: <RouteBase>[
    // Rotas públicas
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage(); // Primeira página carregada
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
    GoRoute(
      path: '/auth-check',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthCheck();
      },
    ),
    // Rotas protegidas
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
    GoRoute(
      path: '/notifications',
      pageBuilder: (BuildContext context, GoRouterState state) {
        if (state.extra == null) {
          context.go('/home');
        }
        return customTransition(
          state,
          NotificationView(
            state.extra as String,
          ),
        );
      },
    ),
  ],
);

CustomTransitionPage customTransition(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    barrierDismissible: true,
    barrierColor: Colors.black38,
    opaque: false,
    transitionDuration: Duration.zero,
    transitionsBuilder: (_, __, ___, Widget child) => child,
  );
}
