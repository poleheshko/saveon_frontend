import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/categories/category_service.dart';
import 'package:saveon_frontend/services/user_service.dart';
import 'package:saveon_frontend/widgets/bottom_navigation/main_navigation.dart';
import 'package:saveon_frontend/widgets/login_flow/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/accounts/account_service.dart';
import 'models/folders/folder_service.dart';
import 'models/summary/summary_service.dart';
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
        ChangeNotifierProvider(create: (_) => AccountService()),
        ChangeNotifierProvider(create: (_) => TransactionService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => FolderService()),
        ChangeNotifierProvider(create: (_) => SummaryService()),
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
      print('🚀 [APP INIT] Starting app initialization...');

      // Fetch user data before showing MainNavigation
      final userService = Provider.of<UserService>(context, listen: false);
      print('👤 [APP INIT] Fetching user data...');
      await userService.fetchCurrentUser();
      print('✅ [APP INIT] User fetched: ${userService.currentUser ?? "null"}');

      // Fetch essential data in parallel for better performance
      final accountService = Provider.of<AccountService>(context, listen: false);
      final categoryService = Provider.of<CategoryService>(context, listen: false);
      final folderService = Provider.of<FolderService>(context, listen: false);

      print('📦 [APP INIT] Fetching essential data in parallel...');
      final stopwatch = Stopwatch()..start();

      // Pobierz wszystkie równolegle (szybsze niż sekwencyjnie)
      await Future.wait([
        accountService.fetchAccounts(),
        categoryService.fetchCategories(),
        folderService.fetchFolders(),
      ]);

      stopwatch.stop();
      print('⏱️ [APP INIT] All data fetched in ${stopwatch.elapsedMilliseconds}ms');

      print('✅ [APP INIT] Initialization complete!\n');
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
