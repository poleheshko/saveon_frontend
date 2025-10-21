import 'package:flutter/material.dart';

import '../../widgets/bottom_navigation/MotionTabBar.dart';

class CommonPage extends StatefulWidget {
  final List<Widget> commonPageContent;

  const CommonPage({required this.commonPageContent, super.key});

  @override
  _CommonPageState createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text("SaveOn!"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.commonPageContent,
          ),
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home", // Change to your default tab
        labels: ["Friends", "Ranking", "Expenses", "Home", "Invest"], // Your tab labels
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
            _currentIndex = index; // Update your current index
          });
        },
      ),
    );
  }
}
