import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/common_page.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPage();
}

class _FriendsPage extends State<FriendsPage> {

  @override
  Widget build(BuildContext context) {
    return CommonPage(commonPageContent: [
      Text("Friends Page")
    ]
    );
  }
}