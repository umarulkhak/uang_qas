import 'package:flutter/material.dart';

// This page is no longer used and is kept to avoid breaking references.
// It can be safely deleted.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This page is deprecated.'),
      ),
    );
  }
}
