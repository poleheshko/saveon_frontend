import 'package:flutter/cupertino.dart';

class SaveOnSpacer extends StatelessWidget {
  const SaveOnSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(color: Color(0xFFC0C0C0), height: 0.2),
        const SizedBox(height: 10),
      ],
    );
  }
}
