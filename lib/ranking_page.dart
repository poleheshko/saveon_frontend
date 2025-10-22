import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/common_page.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPage();
}

class _RankingPage extends State<RankingPage> {

  @override
  Widget build(BuildContext context) {
    return CommonPage(commonPageContent: [
      Text("Ranking Page")
    ]
    );
  }
}