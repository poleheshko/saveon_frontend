import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionTypeSelector extends StatefulWidget {
  const TransactionTypeSelector({super.key});

  @override
  State<TransactionTypeSelector> createState() => _TransactionTypeSelector();
}

enum TransactionType { expense, income }

class _TransactionTypeSelector extends State<TransactionTypeSelector> {
  TransactionType _selected = TransactionType.expense;
  Color selectedBackgroundColor = Color(0xFF5D52FF);
  Color selectedTextColor = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
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
                () => setState(() {
                  _selected = TransactionType.expense;
                }),
          ),
          _buildButton(
            text: 'Income',
            selected: _selected == TransactionType.income,
            onPressed:
                () => setState(() {
                  _selected = TransactionType.income;
                }),
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
