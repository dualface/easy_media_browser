import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const String routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Welcome'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Easy Media Browser',
          style: TextStyle(fontSize: 64),
        ),
      ),
    );
  }
}
