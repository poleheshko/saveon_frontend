import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';

import '../../data/transactions_mocked_data.dart';
import '../home_page_models/payment_history/transaction_prefab.dart';

class TransactionSection extends StatefulWidget {
  const TransactionSection({super.key});

  @override
  State<TransactionSection> createState() => _TransactionSection();
}

class _TransactionSection extends State<TransactionSection> {
  final limitedTransactions = ListTransactionsMockedData.take(10).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SaveOnSection(
          sectionTitle: "12.08.2025",
          SaveOnSectionContent: [
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemCount: limitedTransactions.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TransactionPrefab(transactionId: index),

                    if (index != limitedTransactions.length - 1) ...[
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
}
