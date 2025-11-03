import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';

class CurrentBalance extends StatefulWidget {
  const CurrentBalance({super.key});

  @override
  State<CurrentBalance> createState() => _CurrentBalance();
}

class _CurrentBalance extends State<CurrentBalance> {
  @override
  Widget build(BuildContext context) {
    return SaveOnSection(
      sectionTitle: "Current Balance",
      SaveOnSectionContent: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //big number (current amount)
                Row(
                  children: [
                    Text(
                      '12 899',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: 5),
                    Text('zł', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(width: 10),

                //comparing small number
                Row(
                  children: [
                    Text(
                      '12 899',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Color(0xFFE1075E),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'zł',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Color(0xFFE1075E),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'today',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),

            SvgPicture.asset('lib/assets/other/arrow_next.svg'),
          ],
        ),
      ],
    );
  }
}
