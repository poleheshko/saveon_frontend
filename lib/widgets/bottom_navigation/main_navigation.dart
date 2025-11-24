import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../expense_page.dart';
import '../../friends_page.dart';
import '../../home_page.dart';
import '../../invest_page.dart';
import '../../ranking_page.dart';
import '../../services/user_service.dart';
import 'MotionTabBar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 3;

  final List<Widget> pages = [
    const FriendsPage(),
    const RankingPage(),
    const ExpensePage(),
    const HomePage(),
    const InvestPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Refresh user data when navigation loads (user should already be loaded from main.dart)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userService = Provider.of<UserService>(context, listen: false);
      // Only fetch if user is not already loaded
      if (userService.currentUser == null) {
        userService.fetchCurrentUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        labels: ["Friends", "Ranking", "Expenses", "Home", "Invest"],
        svgIcons: [
          'lib/assets/menu/friendsRegular.svg',
          'lib/assets/menu/rankingRegular.svg',
          'lib/assets/menu/expensesRegular.svg',
          'lib/assets/menu/homeRegular.svg',
          'lib/assets/menu/investRegular.svg',
        ],
        textStyle: TextStyle(color: Colors.black),
        tabIconColor: const Color.fromARGB(255, 0, 0, 0),
        tabIconSelectedColor: const Color.fromARGB(255, 255, 255, 255),
        onTabItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
