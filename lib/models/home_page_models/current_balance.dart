import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';
import 'package:saveon_frontend/models/folders/folder_service.dart';
import 'package:saveon_frontend/models/summary/summary_service.dart';
import 'package:saveon_frontend/utils/date_utils.dart';
import 'package:saveon_frontend/utils/number_utils.dart';

import '../summary/summary_model.dart';

class CurrentBalance extends StatefulWidget {
  const CurrentBalance({super.key});

  @override
  State<CurrentBalance> createState() => _CurrentBalance();
}

class _CurrentBalance extends State<CurrentBalance> {
  SummaryModel? _overallSummary;
  SummaryModel? _todaySummary;
  bool _isLoadingOverall = false;
  bool _isLoadingToday = false;
  String? _errorOverall;
  String? _errorToday;

  @override
  void initState() {
    super.initState();

    //Get summary after first loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchOverallBalance();
      _fetchTodayBalance();
    });
  }

  //Fetch overall Balance Future
  Future<void> _fetchOverallBalance() async {
    setState(() {
      _isLoadingOverall = true;
      _errorOverall = null;
    });

    try {
      final summaryService = Provider.of<SummaryService>(
        context,
        listen: false,
      );
      await summaryService.getSummary();

      if (summaryService.summary.isNotEmpty) {
        setState(() {
          _overallSummary = summaryService.summary.first;
          _isLoadingOverall = false;
        });
      } else {
        setState(() {
          _errorOverall = 'No summary found';
          _isLoadingOverall = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorOverall = 'Error: $e';
        _isLoadingOverall = false;
      });
    }
  }

  //Fetch Balance for Today Future
  Future<void> _fetchTodayBalance() async {
    setState(() {
      _isLoadingToday = true;
      _errorToday = null;
    });

    try {
      final today = DateTime.now();
      final todayString = SaveOnDateUtils.formatDateForApi(today);
      final tomorrow = DateTime.now().add(Duration(days: 1));
      final tomorrowString = SaveOnDateUtils.formatDateForApi(tomorrow);

      final summaryService = Provider.of<SummaryService>(
        context,
        listen: false,
      );
      await summaryService.getSummary(from: todayString, to: tomorrowString);

      if (summaryService.summary.isNotEmpty) {
        setState(() {
          _todaySummary = summaryService.summary.first;
          _isLoadingToday = false;
        });
      } else {
        setState(() {
          _errorToday = 'No summary found';
          _isLoadingToday = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorToday = 'Error: $e';
        _isLoadingToday = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = _isLoadingOverall || _isLoadingToday;
    final hasError = _errorOverall != null || _errorToday != null;
    final hasData = _overallSummary != null;

    if (isLoading && !hasData) {
      return SaveOnSection(
        SaveOnSectionContent: [Center(child: CupertinoActivityIndicator())],
      );
    }

    if (hasError && !hasData) {
      return SaveOnSection(
        SaveOnSectionContent: [
          Center(
            child: Text(
              _errorOverall ?? _errorToday ?? 'Error loading balance',
            ),
          ),
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
                    //big number without currency
                    Text(
                      SaveOnNumberUtils.formatCurrency(_overallSummary?.balance ?? 0.0,),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: 5),

                    //currency
                    Text('zł', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(width: 10),

                //comparing small number
                Row(
                  children: [
                    Text(
                      SaveOnNumberUtils.formatCurrency(_todaySummary?.balance ?? 0.0,),
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
