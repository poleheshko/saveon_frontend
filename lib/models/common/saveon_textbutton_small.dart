import 'package:flutter/material.dart';

class SaveOnTextButtonSmall extends StatelessWidget {
  final Function()? onPressed;
  final String buttonLabel;

  const SaveOnTextButtonSmall({
    super.key,
    required this.onPressed,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, //  bez powiększania na mobile
      ),
      child: Text(
        buttonLabel,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Color(0xFF5D52FF)),
      ),
    );
  }
}
