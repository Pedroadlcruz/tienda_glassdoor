import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/di/service_locator.dart';
import '../../../../core/config/router/app_router_refresh_notifier.dart';
import '../../../auth/domain/usecases/logout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to the Home Page!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          const SizedBox(height: 20, width: double.infinity),
          Visibility(
            // Visible if the user is not authenticated
            visible: !sl<AppRouterRefreshNotifier>().isAuthenticated,
            replacement: ElevatedButton(
              onPressed: () async {
                //Logout
                await sl<Logout>().call();
              },
              child: const Text('Logout'),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to another page or perform an action
                context.go('/login');
              },
              child: const Text('Go to Login'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
