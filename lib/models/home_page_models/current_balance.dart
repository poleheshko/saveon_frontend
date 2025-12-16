import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';
import 'package:saveon_frontend/models/folders/folder_service.dart';
import 'package:saveon_frontend/models/summary/summary_service.dart';

class CurrentBalance extends StatefulWidget {
  const CurrentBalance({super.key});

  @override
  State<CurrentBalance> createState() => _CurrentBalance();
}

class _CurrentBalance extends State<CurrentBalance> {
  @override
  void initState() {
    super.initState();

    //Get summary after first loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SummaryService>(context, listen: false).getSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SummaryService>(
      builder: (context, summaryService, child) {
        final summary = summaryService.summary;

        if (summaryService.isLoading && summary.isEmpty) {
          return SaveOnSection(
            SaveOnSectionContent: [Center(child: CupertinoActivityIndicator())],
          );
        }

        if (summaryService.error != null && summary.isEmpty) {
          return SaveOnSection(
            SaveOnSectionContent: [
              Center(child: Text('Error: ${summaryService.error}')),
            ],
          );
        }

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
                          summary.first.balance.toStringAsFixed(2),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'zł',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),

                    //comparing small number
                    Row(
                      children: [
                        Text(
                          '12 899',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Color(0xFFE1075E)),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'zł',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Color(0xFFE1075E)),
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
      },
    );
  }
}
