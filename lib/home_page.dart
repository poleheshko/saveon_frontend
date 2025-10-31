import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/common_page.dart';
import 'package:saveon_frontend/models/home_page_models/current_balance.dart';
import 'package:saveon_frontend/models/home_page_models/payment_history_short.dart';

import 'models/home_page_models/folders/folders_class.dart';

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
      const SizedBox(height: 20),
      FoldersClass(),
      const SizedBox(height: 20),
      PaymentHistoryShort(),
    ]
    );
  }
}