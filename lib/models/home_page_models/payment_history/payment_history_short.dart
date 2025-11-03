import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';
import 'package:saveon_frontend/models/home_page_models/payment_history/transaction_prefab.dart';

class PaymentHistoryShort extends StatefulWidget {
  const PaymentHistoryShort({super.key});

  @override
  State<PaymentHistoryShort> createState() => _PaymentHistoryShort();
}

class _PaymentHistoryShort extends State<PaymentHistoryShort> {
  final transactionCount = 4;

  @override
  Widget build(BuildContext context) {
    return SaveOnSection(
      sectionTitle: "Payment History",
      SaveOnSectionContent: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          itemCount: transactionCount,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TransactionPrefab(transactionId: index),

                if (index != transactionCount - 1) ...[
                  const SizedBox(height: 10),
                  Container(color: Color(0xFFC0C0C0), height: 0.2),
                  const SizedBox(height: 10),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
