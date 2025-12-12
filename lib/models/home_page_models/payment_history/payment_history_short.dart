import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/categories/category_service.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';
import 'package:saveon_frontend/models/transactions/transaction_prefab_old.dart';

class PaymentHistoryShort extends StatefulWidget {
  const PaymentHistoryShort({super.key});

  @override
  State<PaymentHistoryShort> createState() => _PaymentHistoryShort();
}

class _PaymentHistoryShort extends State<PaymentHistoryShort> {
  final transactionCount = 4;

  @override
  void initState() {
    super.initState();
    // Fetch categories after first loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryService>(context, listen: false).fetchCategories();
    });
  }

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
                TransactionPrefabOld(transactionId: index),

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
