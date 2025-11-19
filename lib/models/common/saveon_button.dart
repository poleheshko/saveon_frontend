import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SaveOnButton extends StatelessWidget {
  final String buttonText;
  final String? buttonIconPath;
  final Function()? onPressed;
  final bool isLoading;

  const SaveOnButton({
    super.key,
    required this.buttonText,
    this.buttonIconPath,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          const Color(0xFF5D52FF),
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(minWidth: 90, minHeight: 35),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            else ...[
              Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (buttonIconPath != null) ...[
                const SizedBox(width: 5),
                SvgPicture.asset(buttonIconPath!, width: 20, height: 20),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
