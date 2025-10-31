import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';
import 'package:saveon_frontend/models/home_page_models/transaction_prefab.dart';

class PaymentHistoryShort extends StatefulWidget {
  const PaymentHistoryShort({super.key});

  @override
  State<PaymentHistoryShort> createState() => _PaymentHistoryShort();
}

class _PaymentHistoryShort extends State<PaymentHistoryShort> {
  @override
  Widget build(BuildContext context) {
    return SaveOnSection(
      sectionTitle: "Payment History",
      SaveOnSectionContent: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          itemCount: 4,
          itemBuilder: (context, index) {
            return TransactionPrefab(transactionId: index);
          },
        ),
      ],
    );
  }
}
