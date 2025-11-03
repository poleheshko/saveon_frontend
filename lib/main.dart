import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saveon_frontend/widgets/bottom_navigation/main_navigation.dart';


void main() {
  runApp(const SaveOn());
}

class SaveOn extends StatelessWidget {
  const SaveOn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          const TextTheme(
              titleMedium: TextStyle(fontSize: 16),
              bodySmall: TextStyle(fontSize: 10),
              bodyMedium: TextStyle(fontSize: 16),
              titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainNavigation(),
    );
  }
}
