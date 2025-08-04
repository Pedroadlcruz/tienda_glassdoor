import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/config/di/service_locator.dart';
import 'core/config/router/app_router.dart';
import 'core/config/router/app_router_refresh_notifier.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sl<AppRouterRefreshNotifier>(),
      child: BlocProvider.value(
        value: sl<AuthBloc>()..add(CheckAuthStatus()),
        child: MaterialApp.router(
          title: 'Tienda Glassdoor',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
