import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';

class ChooseDateClass extends StatefulWidget {
  const ChooseDateClass({super.key});

  State<ChooseDateClass> createState() => _ChooseDateClassState();
}

class _ChooseDateClassState extends State<ChooseDateClass> {
  bool showCalendar = false;

  @override
  Widget build(BuildContext context) {
    return SaveOnSection(
        SaveOnSectionContent: [
          GestureDetector(
            onTap: () {
              setState(() {
                showCalendar = !showCalendar;
              });
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("lib/assets/date_icons/calendar_icon.svg"),
                    SizedBox(width: 3),
                    const Text(
                      "Date",
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ]
                ),
                Row(
                  children: [
                    Text(
                      "05.12.2025",
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(width: 6),

                    showCalendar == false
                    ? SvgPicture.asset("lib/assets/date_icons/arrow_right_icon.svg")
                    : SvgPicture.asset("lib/assets/date_icons/arrow_down_icon.svg"),
                  ]
                ),
              ]
            ),
          )
        ]
    );
  }
}