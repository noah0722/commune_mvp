import 'package:commune/core/models/mu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/features/home/views/home_view.dart';
import 'package:commune/features/auth/views/login_view.dart';
import 'package:commune/features/post/views/post_write_view.dart';
import 'package:commune/features/mu/views/mu_detail_view.dart';
import 'package:commune/features/notification/views/notification_view.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/write',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          final muId = args?['muId'] as String?;
          return PostWriteView(
            muId: muId ?? '', // Provide default empty string if null
          );
        },
      ),
      GoRoute(
        path: '/mu/:muId',
        builder: (context, state) {
          final muId = state.pathParameters['muId'] ??
              ''; // Provide default empty string if null
          return MuDetailView(
            muId: muId,
          );
        },
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationView(),
      ),
    ],
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      return authState.when(
        data: (user) {
          final isLoggedIn = user != null;
          final isLoggingIn = state.matchedLocation == '/login';

          if (isLoggedIn && isLoggingIn) {
            return '/'; // Redirect to home if logged in and trying to access login
          }
          if (!isLoggedIn && _requiresAuth(state.matchedLocation)) {
            return '/login'; // Redirect to login if not logged in and accessing protected route
          }
          return null; // No redirect
        },
        loading: () => null,
        error: (_, __) => '/login',
      );
    },
  );
});

bool _requiresAuth(String location) {
  final protectedRoutes = [
    '/write',
    '/profile',
    '/commore',
    '/my-posts',
    '/admin',
  ];
  return protectedRoutes.any(location.startsWith);
}
