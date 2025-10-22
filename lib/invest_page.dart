import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/common_page.dart';

class InvestPage extends StatefulWidget {
  const InvestPage({super.key});

  @override
  State<InvestPage> createState() => _InvestPage();
}

class _InvestPage extends State<InvestPage> {

  @override
  Widget build(BuildContext context) {
    return CommonPage(commonPageContent: [
      Text("Invest Page")
    ]
    );
  }
}