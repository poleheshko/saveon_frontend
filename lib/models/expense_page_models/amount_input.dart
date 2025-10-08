import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmountInput extends StatefulWidget {
  const AmountInput({super.key});

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // odśwież UI, gdy focus się zmienia
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w600,
        color: Color(0xFF000000),
      ),
      showCursor: _focusNode.hasFocus,
      autofocus: true, //żeby automatycznie właczało się wprowadzanie, jak wchodzisz na stronę
      cursorColor: Color(0xFF659BFF),
      cursorWidth: 2,
      decoration: InputDecoration(
          border: InputBorder.none,
          suffixText: 'zł',
          suffixStyle: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
          ),
      ),
    );
  }
}
