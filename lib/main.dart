import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/categories/category_service.dart';
import 'package:saveon_frontend/services/user_service.dart';
import 'package:saveon_frontend/widgets/bottom_navigation/main_navigation.dart';
import 'package:saveon_frontend/widgets/login_flow/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/folders/folder_service.dart';
import 'models/transactions/transaction_service.dart';


void main() {
  runApp(const SaveOn());
}

class SaveOn extends StatelessWidget {
  const SaveOn({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserService()),
        ChangeNotifierProvider(create: (_) => TransactionService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => FolderService()),
      ],

      child: MaterialApp(
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
        home: const _AppInitializer(),
      ),
    );
  }
}

class _AppInitializer extends StatefulWidget {
  const _AppInitializer();

  @override
  State<_AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<_AppInitializer> {
  bool _isInitializing = true;
  bool? _hasSession;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSession = prefs.getBool('isLoggedIn') ?? false;

    if (hasSession) {
      // Fetch user data before showing MainNavigation
      final userService = Provider.of<UserService>(context, listen: false);
      await userService.fetchCurrentUser();
    }

    if (mounted) {
      setState(() {
        _hasSession = hasSession;
        _isInitializing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return _hasSession! ? const MainNavigation() : const SaveonLoginPage();
  }
}
