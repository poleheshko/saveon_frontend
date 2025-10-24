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
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, //  bez powiększania na mobile
      ),
      child: Text(
        buttonLabel,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Color(0xFF5D52FF)),
      ),
    );
  }
}
