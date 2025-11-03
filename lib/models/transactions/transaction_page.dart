import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/transactions/transactions_section.dart';

import '../common/common_page.dart';

class TransacitonPage extends StatefulWidget {
  const TransacitonPage({super.key});

  @override
  State<TransacitonPage> createState() => _TransacitonPage();
}

class _TransacitonPage extends State<TransacitonPage> {
  @override
  Widget build(BuildContext context) {
    return CommonPage(
      commonPageContent: [
        TransactionSection(),
      ],
    );
  }
}
