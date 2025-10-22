import 'package:flutter/material.dart';
import 'package:saveon_frontend/widgets/bottom_navigation/main_navigation.dart';

import 'expense_page.dart';

void main() {
  runApp(const SaveOn());
}

class SaveOn extends StatelessWidget {
  const SaveOn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainNavigation(),
    );
  }
}

