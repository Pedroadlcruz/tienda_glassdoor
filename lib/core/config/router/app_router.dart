import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/data/models/app_user.dart';
import '../../../features/auth/presentation/blocs/login/login_bloc.dart';
import '../../../features/auth/presentation/blocs/register/register_bloc.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/register_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../config/di/service_locator.dart';
import '../../widgets/no_network_page.dart';
import 'app_router_refresh_notifier.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    refreshListenable: sl<AppRouterRefreshNotifier>(),
    redirect: (context, state) {
      final notifier = sl<AppRouterRefreshNotifier>();

      print(
        '[DEBUG] Router redirect - isOnline: ${notifier.isOnline}, currentUser: ${notifier.currentUser.email}, location: ${state.matchedLocation}',
      );

      // Redirect to /nonetwork if no connection
      if (!notifier.isOnline) {
        print(
          '[DEBUG] Router redirect - no connection, redirecting to /nonetwork',
        );
        return '/nonetwork';
      }

      // Routes that require authentication
      final protectedRoutes = ['/cart', '/profile'];

      // Check if current route requires authentication
      final requiresAuth = protectedRoutes.any(
        (route) => state.matchedLocation.startsWith(route),
      );

      // Redirect to login if accessing protected route without auth
      if (notifier.currentUser == AppUser.empty && requiresAuth) {
        print(
          '[DEBUG] Router redirect - protected route accessed without auth',
        );
        return '/login';
      }

      // Redirect authenticated users away from auth routes
      if (notifier.currentUser != AppUser.empty &&
          (state.matchedLocation == '/login' ||
              state.matchedLocation == '/register')) {
        print('[DEBUG] Router redirect - authenticated user on auth route');
        return '/home';
      }

      print('[DEBUG] No redirect needed');
      return null;
    },
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
        routes: const [
          // GoRoute(
          //   path: 'product/:id',
          //   name: 'product-detail',
          //   builder: (context, state) {
          //     final productId = state.pathParameters['id']!;
          //     return ProductDetailPage(productId: productId);
          //   },
          // ),
          // GoRoute(
          //   path: 'cart',
          //   name: 'cart',
          //   builder: (context, state) => const CartPage(),
          // ),
          // GoRoute(
          //   path: 'profile',
          //   name: 'profile',
          //   builder: (context, state) => const ProfilePage(),
          // ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => BlocProvider.value(
          value: sl<LoginBloc>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => BlocProvider.value(
          value: sl<RegisterBloc>(),
          child: const RegisterPage(),
        ),
      ),
      GoRoute(
        path: '/nonetwork',
        name: 'nonetwork',
        builder: (context, state) => const NoNetworkPage(),
      ),
      // GoRoute(
      //   path: '/splash',
      //   name: 'splash',
      //   builder: (context, state) => const SplashPage(),
      // ),
      // Redirect root to home
      GoRoute(path: '/', redirect: (context, state) => '/home'),
    ],
  );
}
