import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          ElevatedButton(
            onPressed: () {
              // Navigate to another page or perform an action
              context.go('/login');
            },
            child: const Text('Go to Login'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
