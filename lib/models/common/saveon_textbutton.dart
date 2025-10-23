import 'package:flutter/material.dart';

class SaveOnTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonLabel;

  const SaveOnTextButton({
    super.key,
    required this.onPressed,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonLabel,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Color(0xFF5D52FF)),
      ),
    );
  }
}
