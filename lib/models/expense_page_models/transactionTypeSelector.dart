import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionTypeSelector extends StatefulWidget {
  const TransactionTypeSelector({
    super.key,
    this.initialValue = TransactionType.expense,
    this.onChanged,
  });

  final TransactionType initialValue;
  final ValueChanged<TransactionType>? onChanged;

  @override
  State<TransactionTypeSelector> createState() => _TransactionTypeSelector();
}

enum TransactionType { expense, income }

extension TransactionTypeExtension on TransactionType {
  /// Wartość do wysłania do API (np. "EXPENSE", "INCOME").
  String get apiValue => switch (this) {
    TransactionType.expense => 'EXPENSE',
    TransactionType.income => 'INCOME',
  };
}

class _TransactionTypeSelector extends State<TransactionTypeSelector> {
  late TransactionType _selected;
  static const Color selectedBackgroundColor = Color(0xFF5D52FF);
  static const Color selectedTextColor = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  void setSelected(TransactionType type) {
    if (_selected == type) return;

    setState (() {
      _selected = type;
    });

    widget.onChanged?.call(type);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 202,
      height: 35,
      clipBehavior: Clip.hardEdge, // żeby orzycisk był przy krawędzi
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Color(0xFF5D52FF), width: 1),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton(
            text: 'Expense',
            selected: _selected == TransactionType.expense,
            onPressed:
                () => setSelected(TransactionType.expense)
          ),
          _buildButton(
            text: 'Income',
            selected: _selected == TransactionType.income,
            onPressed:
                () => setSelected(TransactionType.income)
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required bool selected,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 100,
      height: 35,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: selected ? selectedBackgroundColor : Color(0x00000000),
          foregroundColor: selected ? selectedTextColor : Color(0xFF5D52FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
