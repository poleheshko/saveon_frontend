import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/common_page.dart';
import 'package:saveon_frontend/models/home_page_models/current_balance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return CommonPage(commonPageContent: [
      CurrentBalance(),
    ]
    );
  }
}