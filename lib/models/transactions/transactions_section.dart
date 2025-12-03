import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';
import 'package:saveon_frontend/models/transactions/transaction_model.dart';
import 'package:saveon_frontend/models/transactions/transaction_prefab.dart';

import '../../data/transactions_mocked_data.dart';
import 'transaction_prefab_old.dart';

class TransactionSection extends StatefulWidget {
  final DateTime date;
  final List<TransactionModel> transactions;

  const TransactionSection({
    super.key,
    required this.date,
    required this.transactions,
  });

  @override
  State<TransactionSection> createState() => _TransactionSection();
}

class _TransactionSection extends State<TransactionSection> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SaveOnSection(
          sectionTitle: _formatDate(widget.date),
          SaveOnSectionContent: [
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemCount: widget.transactions.length,
              itemBuilder: (context, index) {
                final transaction = widget.transactions[index];

                return Column(
                  children: [
                    TransactionPrefab(transaction: transaction),

                    if (index != widget.transactions.length - 1) ...[
                      const SizedBox(height: 10),
                      Container(color: Color(0xFFC0C0C0), height: 0.2),
                      const SizedBox(height: 10),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }
}
