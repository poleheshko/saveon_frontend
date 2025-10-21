library motiontabbar;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'MotionTabBarController.dart';
import 'MotionTabItem.dart';
import 'helpers/HalfClipper.dart';
import 'helpers/HalfPainter.dart';

typedef MotionTabBuilder = Widget Function();

class MotionTabBar extends StatefulWidget {
  final Color? tabIconColor, tabIconSelectedColor, tabSelectedColor, tabBarColor;
  final double? tabIconSize, tabIconSelectedSize, tabBarHeight, tabSize;
  final TextStyle? textStyle;
  final Function? onTabItemSelected;
  final String initialSelectedTab;

  final List<String?> labels;
  final List<String> svgIcons;
  final bool useSafeArea;
  final MotionTabBarController? controller;

  // badge
  final List<Widget?>? badges;

  MotionTabBar({
    this.textStyle,
    this.tabIconColor = Colors.black,
    this.tabIconSize = 30,
    this.tabIconSelectedColor = Colors.white,
    this.tabIconSelectedSize = 30,
    this.tabSelectedColor = const Color(0xFF5D52FF),
    this.tabBarColor = Colors.white,
    this.tabBarHeight = 85,
    this.tabSize = 40,
    this.onTabItemSelected,
    required this.initialSelectedTab,
    required this.labels,
    required this.svgIcons,
    this.useSafeArea = true,
    this.badges,
    this.controller,
  })  : assert(labels.contains(initialSelectedTab)),
        assert(svgIcons.length == labels.length, // Ensure lengths match
            "svgIcons and labels must have the same length"),
        assert((badges != null && badges.isNotEmpty)
            ? badges.length == labels.length
            : true);

  @override
  _MotionTabBarState createState() => _MotionTabBarState();
}

class Custom70PercentClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // Clip the bottom 70% of the circle
    return Rect.fromLTRB(0, 0, size.width, size.height * 0.30); // Top 30% visible
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}

class _MotionTabBarState extends State<MotionTabBar> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Tween<double> _positionTween;
  late Animation<double> _positionAnimation;

  late AnimationController _fadeOutController;
  late Animation<double> _fadeFabOutAnimation;
  late Animation<double> _fadeFabInAnimation;

  late List<String?> labels;
  late List<String> svgIcons;

  get tabAmount => labels.length;
  get index => labels.indexOf(selectedTab);

  double fabIconAlpha = 1;
  late String activeIcon;
  String? selectedTab;

  bool isRtl = false;
  List<Widget>? badges;
  Widget? activeBadge;

  double getPosition(bool isRTL) {
    double pace = 2 / (labels.length - 1);
    double position = (pace * index) - 1;

    if (isRTL) {
      // If RTL, reverse the position calculation
      position = 1 - (pace * index);
    }

    return position;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isRtl = Directionality.of(context).index == 0;
    });

    if (widget.controller != null) {
    widget.controller!.onTabChange = (index) {
      setState(() {
        activeIcon = widget.svgIcons[index];
        selectedTab = widget.labels[index];
      });
      _initAnimationAndStart(_positionAnimation.value, getPosition(isRtl));
    };
  }
    labels = widget.labels;
    svgIcons = widget.svgIcons;

    selectedTab = widget.initialSelectedTab;
    activeIcon = svgIcons[labels.indexOf(selectedTab)]; // Use svgIcons instead of icons

    // init badge text
    int selectedIndex = labels.indexWhere((element) => element == widget.initialSelectedTab);
    activeBadge = (widget.badges != null && widget.badges!.length > 0) ? widget.badges![selectedIndex] : null;

    _animationController = AnimationController(
      duration: Duration(milliseconds: ANIM_DURATION),
      vsync: this,
    );

    _fadeOutController = AnimationController(
      duration: Duration(milliseconds: (ANIM_DURATION ~/ 5)),
      vsync: this,
    );

    _positionTween = Tween<double>(begin: getPosition(isRtl), end: 1);

    _positionAnimation = _positionTween.animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _fadeFabOutAnimation = Tween<double>(begin: 1, end: 0)
        .animate(CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabOutAnimation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            // Calculate selectedIndex first
            int selectedIndex = labels.indexWhere((element) => element == selectedTab);
            
            // Then use it to update activeIcon and activeBadge
            activeIcon = svgIcons[selectedIndex]; // Use svgIcons
            activeBadge = (widget.badges != null && widget.badges!.length > selectedIndex)
                ? widget.badges![selectedIndex]
                : null;
          });
        }
      });

    _fadeFabInAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _animationController, curve: Interval(0.8, 1, curve: Curves.easeOut)))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabInAnimation.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.tabBarColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18), // Adjust for top-left rounded corner
          topRight: Radius.circular(18), // Adjust for top-right rounded corner
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(69, 0, 0, 0),
            offset: Offset(0, -1),
            blurRadius: 6,
          ),
        ],
      ),
      child: SafeArea(
        bottom: widget.useSafeArea,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: widget.tabBarHeight,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18), // Adjust for top-left rounded corner
                  topRight: Radius.circular(18), // Adjust for top-right rounded corner
                ),
                color: widget.tabBarColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: generateTabItems(),
              ),
            ),
            IgnorePointer(
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Align(
                  heightFactor: 0,
                  alignment: Alignment(_positionAnimation.value, -0.4),
                  child: FractionallySizedBox(
                    widthFactor: 1 / tabAmount,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: widget.tabSize! + 40,
                          width: widget.tabSize! + 30,
                          child: ClipRect(
                            clipper: Custom70PercentClipper(),
                            child: Container(
                              child: Center(
                                child: Container(
                                  width: widget.tabSize! + 20,
                                  height: widget.tabSize! + 20,
                                  decoration: BoxDecoration(
                                    color: widget.tabBarColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(69, 0, 0, 0),
                                        blurRadius: 6,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.tabSize! + 15,
                          width: widget.tabSize! + 35,
                          child: CustomPaint(painter: HalfPainter(color: widget.tabBarColor)),
                        ),
                        SizedBox(
                          height: widget.tabSize,
                          width: widget.tabSize,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.tabSelectedColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Opacity(
                                opacity: fabIconAlpha,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      activeIcon, // Use activeIcon dynamically for the FAB
                                      colorFilter: widget.tabIconSelectedColor != null
                                          ? ColorFilter.mode(
                                              widget.tabIconSelectedColor!,
                                              BlendMode.srcIn,
                                            )
                                          : null,
                                      width: widget.tabIconSelectedSize ?? widget.tabIconSize,
                                      height: widget.tabIconSelectedSize ?? widget.tabIconSize,
                                    ),
                                    activeBadge != null
                                        ? Positioned(
                                      top: 0,
                                      right: 0,
                                      child: activeBadge!,
                                    )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateTabItems() {
  bool isRtl = Directionality.of(context).index == 0;
  print("Labels: $labels");
print("SVG Icons: $svgIcons");

  return labels.map((tabLabel) {
    int index = labels.indexOf(tabLabel); // Find the index of the current tab label

    return MotionTabItem(
      svgPath: svgIcons[index], // Pass the specific SVG path
      selected: selectedTab == tabLabel, // Highlight the selected tab
      title: tabLabel, // Set the tab's title
      tabIconColor: widget.tabIconColor ?? Colors.black,
      tabIconSize: widget.tabIconSize,
      textStyle: widget.textStyle ?? TextStyle(color: Colors.black), // Add this
      badge: widget.badges != null && widget.badges!.length > index
          ? widget.badges![index]
          : null, // Add badge if available
      callbackFunction: () {
        setState(() {
          selectedTab = tabLabel; // Update selected tab
          widget.onTabItemSelected?.call(index); // Notify the parent of the selection
        });
        _initAnimationAndStart(_positionAnimation.value, getPosition(isRtl));
      },
    );
  }).toList();
}


  _initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;

    _animationController.reset();
    _fadeOutController.reset();
    _animationController.forward();
    _fadeOutController.forward();
  }
}
