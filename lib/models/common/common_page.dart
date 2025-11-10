import 'package:flutter/material.dart';

import 'header_profile.dart';

class CommonPage extends StatelessWidget {
  final List<Widget> commonPageContent;

  const CommonPage({required this.commonPageContent, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(122),
        child: HeaderProfile(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 122 + 16, 17, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: commonPageContent,
          ),
        ),
      ),
    );
  }
}