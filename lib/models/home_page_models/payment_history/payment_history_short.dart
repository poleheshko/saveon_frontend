import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';

import '../../transactions/transaction_model.dart';
import '../../transactions/transaction_prefab.dart';
import '../../transactions/transaction_service.dart';

class PaymentHistoryShort extends StatefulWidget {
  const PaymentHistoryShort({super.key});

  @override
  State<PaymentHistoryShort> createState() => _PaymentHistoryShort();
}

class _PaymentHistoryShort extends State<PaymentHistoryShort> {
  final transactionCount = 5;

  @override
  void initState() {
    super.initState();
    // Fetch categories after first loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionService>(context, listen: false).fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionService>(
      builder: (context, transactionService, child) {
        final transactions = transactionService.transactions;

        // 1) Ładowanie + brak danych
        if (transactionService.isLoading && transactions.isEmpty) {
          return CupertinoActivityIndicator();
        }

        // 2) Błąd + Brak danych
        if (transactionService.error != null && transactions.isEmpty) {
          return Text('Error: ${transactionService.error}');
        }

        // 3) Brak transakcji
        if(transactions.isEmpty) {
          return Text('No transactions found');
        }

        // Sortuj według daty (najnowsze pierwsze) i weź pierwsze 5
        final sortedTransactions = List<TransactionModel>.from(transactions)
          ..sort((a, b) {
            return b.date.compareTo(a.date);
          });
        final latestTransactions = sortedTransactions.take(transactionCount).toList();

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
                    TransactionPrefab(transaction: latestTransactions[index]),

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
    );
  }
}
