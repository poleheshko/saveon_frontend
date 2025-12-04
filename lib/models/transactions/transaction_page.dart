import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/transactions/transaction_model.dart';
import 'package:saveon_frontend/models/transactions/transaction_service.dart';
import 'package:saveon_frontend/models/transactions/transactions_section.dart';

import '../common/common_page.dart';

class TransacitonPage extends StatefulWidget {
  const TransacitonPage({super.key});

  @override
  State<TransacitonPage> createState() => _TransacitonPage();
}

class _TransacitonPage extends State<TransacitonPage> {
  @override
  void initState() {
    super.initState();
    // Pobieramy transakcje po pierwszym zbudowaniu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionService>(
        context,
        listen: false,
      ).fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionService>(
      builder: (context, transactionService, child) {
        final transactions = transactionService.transactions;

        // 1) Ładowanie + brak danych
        if (transactionService.isLoading && transactions.isEmpty) {
          return CommonPage(
            commonPageContent: const [
              Center(child: CupertinoActivityIndicator()),
            ],
          );
        }

        // 2) Błąd + Brak danych
        if (transactionService.error != null && transactions.isEmpty) {
          return CommonPage(
            commonPageContent: [
              Center(child: Text('Error: ${transactionService.error}'))
            ],
          );
        }

        // 3) Brak transakcji
        if(transactions.isEmpty) {
          return CommonPage(
            commonPageContent: [
              Center(child: Text('No transactions found'))
            ],
          );
        }

        // 4) Grupowanie po dacie
        final grouped = _groupedTransactionsByDate(transactions);

        // 5) Tworzymy listę sekcji (po jednej na dzień)
        final sections = grouped.entries.map((entry) {
          final date = entry.key;
          final dayTransactions = entry.value;

          return Column(
            children: [
              TransactionSection(
                date: date,
                transactions: dayTransactions,
              ),
              SizedBox(height: 20)
            ],
          );
        }).toList();

        return CommonPage(
          commonPageContent: sections,
        );


      },
    );
  }

  //Metoda do grupowania transakcji
  Map<DateTime, List<TransactionModel>> _groupedTransactionsByDate(
    List<TransactionModel> transactions,
  ) {
    final Map<DateTime, List<TransactionModel>> grouped = {};

    for (final t in transactions) {
      final key = DateTime(t.date.year, t.date.month, t.date.day);

      grouped.putIfAbsent(key, () => []);
      grouped[key]?.add(t);
    }

    //najnowsze daty na górze
    final sorted =
        grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key));

    return Map.fromEntries(sorted);
  }
}
