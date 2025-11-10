import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saveon_frontend/widgets/bottom_navigation/main_navigation.dart';
import 'package:saveon_frontend/widgets/login_flow/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const SaveOn());
}

class SaveOn extends StatelessWidget {
  const SaveOn({super.key});

  Future<bool> _hasSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

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
              headlineMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder<bool>(
        future: _hasSession(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data!
              ? const MainNavigation()
              : const SaveonLoginPage();
        },
      ),
    );
  }
}
