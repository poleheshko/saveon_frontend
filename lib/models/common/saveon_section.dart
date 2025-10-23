import 'package:flutter/material.dart';
import 'package:saveon_frontend/models/common/saveon_textbutton.dart';

class SaveOnSection extends StatelessWidget {
  final String? sectionTitle;
  final String? textLabelButton;
  final VoidCallback? textButtonOnPressed;
  final List<Widget> SaveOnSectionContent;

  const SaveOnSection({
    required this.SaveOnSectionContent,
    this.textLabelButton,
    this.sectionTitle,
    this.textButtonOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle != null && textLabelButton == null
            ? Text(
              sectionTitle!,
              style: Theme.of(context).textTheme.titleMedium,
            )
            : sectionTitle != null && textLabelButton != null
            ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  sectionTitle!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SaveOnTextButton(
                  onPressed: textButtonOnPressed,
                  buttonLabel: textLabelButton!,
                )
              ],
            )
            : SizedBox.shrink(),
        const SizedBox(height: 10),

        Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: SaveOnSectionContent,
          ),
        ),
      ],
    );
  }
}
