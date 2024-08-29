import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sigs_certifica_app/data/services/auth/api_auth_service.dart';
import 'package:sigs_certifica_app/locator.dart';
import 'package:sigs_certifica_app/presentation/views/auth/login_view.dart';
import 'package:sigs_certifica_app/presentation/views/home_view.dart';
import 'package:sigs_certifica_app/presentation/views/notification/notification_view.dart';
import 'package:sigs_certifica_app/widgets/auth_check.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    if (!getIt<ApiAuthService>().isLogged()) {
      return '/login';
    }

    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/auth-check',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthCheck();
      },
    ),
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
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return LoginView();
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
