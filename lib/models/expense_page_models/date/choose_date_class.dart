import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';

class ChooseDateClass extends StatefulWidget {
  final Function(DateTime)? onDateSelected; // ✅ callback, który pózniej przekaże dane do expense page)

  const ChooseDateClass({super.key, this.onDateSelected});

  State<ChooseDateClass> createState() => _ChooseDateClassState();
}

class _ChooseDateClassState extends State<ChooseDateClass> {
  bool showCalendar = false;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return SaveOnSection(
      SaveOnSectionContent: [
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();

            setState(() {
              showCalendar = !showCalendar;
            });
          },
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "lib/assets/date_icons/calendar_icon.svg",
                      ),
                      SizedBox(width: 3),
                      const Text(
                        "Date",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        formatDate(selectedDate), // 👈 tutaj formatujemy
                        style: const TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 6),

                      showCalendar == false
                          ? SvgPicture.asset(
                            "lib/assets/date_icons/arrow_right_icon.svg",
                          )
                          : SvgPicture.asset(
                            "lib/assets/date_icons/arrow_down_icon.svg",
                          ),
                    ],
                  ),
                ],
              ),
              if (showCalendar) ...[
                SizedBox(height: 25),
                Container(
                  height: 250,
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      calendarType: CalendarDatePicker2Type.single, // 🟢 pojedynczy wybór
                      selectedDayHighlightColor: const Color(0xFFCECBFF), // 💚 Twój SaveOn Green
                      weekdayLabelTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF666666),
                      ),
                      dayTextStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    value: [selectedDate],
                    onValueChanged: (dates) {
                      setState(() {
                        selectedDate = dates.first ?? DateTime.now();
                        showCalendar = !showCalendar;
                      });

                      widget.onDateSelected?.call(selectedDate); // wywołuję callback z wybraną datą
                    },
                  )
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
