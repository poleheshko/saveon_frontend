import 'package:flutter/material.dart';

class CommonPage extends StatelessWidget {
  final List<Widget> commonPageContent;

  const CommonPage({required this.commonPageContent, super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: commonPageContent,
          ),
        ),
      ),
    );
  }
}
