import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AmountInput extends StatefulWidget {
  final Function(double)? onAmountChanged; // 👈 callback do rodzica

  const AmountInput({super.key, this.onAmountChanged});

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final NumberFormat _formatter = NumberFormat('#,##0', 'en_US'); // bez .00

  @override
  void initState() {
    super.initState();
    _controller.text = '0';
  }

  String _formatInput(String input) {
    // usuń przecinki
    final cleaned = input.replaceAll(',', '');

    // jeśli tylko ".", zostaw "0."
    if (cleaned == '.') return '0.';

    // jeśli zaczyna się od ".", dodaj "0"
    if (cleaned.startsWith('.')) return '0$cleaned';

    // jeśli kończy się na ".", zostaw kropkę
    if (cleaned.endsWith('.')) {
      final intPart = cleaned.substring(0, cleaned.length - 1);
      if (intPart.isEmpty) return '0.';
      final formattedInt = _formatter.format(int.parse(intPart));
      return '$formattedInt.';
    }

    // jeśli liczba ma kropkę (część dziesiętną)
    if (cleaned.contains('.')) {
      final parts = cleaned.split('.');
      final intPart = parts[0].isEmpty ? '0' : parts[0];
      String decPart = parts.length > 1 ? parts[1] : '';

      // 🧩 ogranicz do max 2 cyfr po przecinku
      if (decPart.length > 2) {
        decPart = decPart.substring(0, 2);
      }

      final formattedInt = _formatter.format(int.parse(intPart));
      return decPart.isEmpty ? '$formattedInt.' : '$formattedInt.$decPart';
    }

    // zwykłe liczby całkowite
    final num? parsed = num.tryParse(cleaned);
    if (parsed == null) return input;
    return _formatter.format(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntrinsicWidth(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  onChanged: (value) {
                    // zapamiętaj pozycję kursora
                    final oldPos = _controller.selection.baseOffset;
                    final newText = _formatInput(value);

                    // tylko jeśli tekst faktycznie się zmienił
                    if (newText != value) {
                      _controller.value = TextEditingValue(
                        text: newText,
                        selection: TextSelection.collapsed(
                          offset: (oldPos + (newText.length - value.length))
                              .clamp(0, newText.length),
                        ),
                      );
                    }

                    // ✅ przekazanie wartości do rodzica
                    final cleanedValue =
                    newText.replaceAll(',', '').replaceAll(' ', '');
                    final double? parsed = double.tryParse(cleanedValue);
                    if (parsed != null && widget.onAmountChanged != null) {
                      widget.onAmountChanged!(parsed);
                    }
                  },
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                  showCursor: _focusNode.hasFocus,
                  autofocus: true,
                  cursorColor: const Color(0xFF659BFF),
                  cursorWidth: 2,
                  cursorHeight: 50,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'zł',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
              ),
            ],
          ),

          Text('Amount', style: TextStyle(
            color: Color(0xFF959595),
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),)
        ],
      ),
    );
  }
}
