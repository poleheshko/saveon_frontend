import 'package:flutter/material.dart';

class SaveOnSection extends StatelessWidget {
  final List<Widget> SaveOnSectionContent;

  const SaveOnSection({required this.SaveOnSectionContent, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 46),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF), //background
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // cień
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: SaveOnSectionContent,
      ),
    );
  }
}
