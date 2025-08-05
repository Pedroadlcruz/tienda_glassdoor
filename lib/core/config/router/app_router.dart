import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/data/models/app_user.dart';
import '../../../features/auth/presentation/blocs/login/login_bloc.dart';
import '../../../features/auth/presentation/blocs/register/register_bloc.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/register_page.dart';
import '../../../features/cart/presentation/blocs/cart/cart_bloc.dart';
import '../../../features/cart/presentation/pages/cart_page.dart';
import '../../../features/products/presentation/blocs/product_detail/product_detail_bloc.dart';
import '../../../features/products/presentation/blocs/products/products_bloc.dart';
import '../../../features/products/presentation/pages/home_page.dart';
import '../../../features/products/presentation/pages/product_detail_page.dart';
import '../../../features/products/presentation/pages/profile_page.dart';
import '../../config/di/service_locator.dart';
import '../../widgets/no_network_page.dart';
import 'app_router_refresh_notifier.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    refreshListenable: sl<AppRouterRefreshNotifier>(),
    redirect: (context, state) {
      final notifier = sl<AppRouterRefreshNotifier>();

      // Redirect to /nonetwork if no connection
      if (!notifier.isOnline) {
        return '/nonetwork';
      }

      if (notifier.isOnline && state.matchedLocation == '/nonetwork') {
        return '/home';
      }

      // Routes that require authentication
      final protectedRoutes = ['/cart', '/profile'];

      // Check if current route requires authentication
      final requiresAuth = protectedRoutes.any(
        (route) => state.matchedLocation.startsWith(route),
      );

      // Redirect to login if accessing protected route without auth
      if (notifier.currentUser == AppUser.empty && requiresAuth) {
        return '/login';
      }

      // Redirect authenticated users away from auth routes
      if (notifier.currentUser != AppUser.empty &&
          (state.matchedLocation == '/login' ||
              state.matchedLocation == '/register')) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: sl<ProductsBloc>()..add(LoadProducts())),
            BlocProvider.value(
              value: sl<CartBloc>()
                ..add(LoadCart(sl<AppRouterRefreshNotifier>().currentUser.id)),
            ),
          ],
          child: const HomePage(),
        ),
        routes: [
          GoRoute(
            path: 'product/:id',
            name: 'product-detail',
            builder: (context, state) {
              final productId = state.pathParameters['id']!;
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: sl<ProductDetailBloc>()
                      ..add(LoadProductDetail(productId)),
                  ),
                  BlocProvider.value(
                    value: sl<CartBloc>()
                      ..add(
                        LoadCart(sl<AppRouterRefreshNotifier>().currentUser.id),
                      ),
                  ),
                ],
                child: const ProductDetailPage(),
              );
            },
          ),
          GoRoute(
            path: 'cart/:userId',
            name: 'cart',
            builder: (context, state) {
              final userId = state.pathParameters['userId']!;
              return BlocProvider.value(
                value: sl<CartBloc>()..add(LoadCart(userId)),
                child: const CartPage(),
              );
            },
          ),
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
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
