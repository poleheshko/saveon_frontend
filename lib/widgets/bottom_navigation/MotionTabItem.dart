import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double ICON_OFF = -2; // Move the icon closer to the center
const double ICON_ON = -0.35; // Keep the icon centered for unselected tabs
const double TEXT_OFF = 0.8; // Move text closer to the center
const double TEXT_ON = 0.8; // Keep text centered for selected tabs
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;
const int ANIM_DURATION = 300;

class MotionTabItem extends StatefulWidget {
  final String? title;
  final bool selected;
  final IconData? iconData;
  final String? svgPath;
  final TextStyle textStyle;
  final Function callbackFunction;
  final Color tabIconColor;
  final double? tabIconSize;
  final Widget? badge;

  const MotionTabItem({super.key, 
    required this.title,
    required this.selected,
    this.iconData, // Optional: For older `IconData` usage
    this.svgPath,  // NEW: For SVG icons
    required this.textStyle,
    required this.tabIconColor,
    this.tabIconSize = 30,
    this.badge,
    required this.callbackFunction,
  });

  @override
  _MotionTabItemState createState() => _MotionTabItemState();
}

class _MotionTabItemState extends State<MotionTabItem> {
  double iconYAlign = ICON_ON;
  double textYAlign = TEXT_OFF;
  double iconAlpha = ALPHA_ON;

  @override
  void initState() {
    super.initState();
    _setIconTextAlpha();
  }

  @override
  void didUpdateWidget(MotionTabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setIconTextAlpha();
  }

  _setIconTextAlpha() {
    setState(() {
      iconYAlign = (widget.selected) ? ICON_OFF : ICON_ON;
      textYAlign = (widget.selected) ? TEXT_ON : TEXT_OFF;
      iconAlpha = (widget.selected) ? ALPHA_OFF : ALPHA_ON;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("SVG Path: ${widget.svgPath}");
    print("Icon Data: ${widget.iconData}");
    print("Tab Icon Color: ${widget.tabIconColor}");
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            child: AnimatedAlign(
              duration: Duration(milliseconds: ANIM_DURATION),
              alignment: Alignment(0, textYAlign),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title!,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  softWrap: false,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => widget.callbackFunction(),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: AnimatedAlign(
                duration: Duration(milliseconds: ANIM_DURATION),
                alignment: Alignment(0, iconYAlign),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: ANIM_DURATION),
                  opacity: iconAlpha,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (widget.svgPath != null && widget.svgPath!.isNotEmpty)
                        SvgPicture.asset(
                          widget.svgPath!, // Path to the SVG file
                          width: widget.tabIconSize, // Set width
                          height: widget.tabIconSize, // Set height
                        )
                      else if (widget.iconData != null)
                        Icon(
                          widget.iconData,
                          color: widget.selected
                              ? widget.tabIconColor
                              : widget.tabIconColor.withOpacity(0.6),
                          size: widget.tabIconSize,
                        )
                      else
                        const SizedBox.shrink(), // Render nothing if both svgPath and iconData are null

                      // Render badge if provided
                      if (widget.badge != null)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: widget.badge!,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}