import 'package:flutter/cupertino.dart';

class StatefulBoilerplate extends StatefulWidget {
  const StatefulBoilerplate({super.key});

  @override
  State<StatefulBoilerplate> createState() => _StatefulBoilerplate();
}

class _StatefulBoilerplate extends State<StatefulBoilerplate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('F');
  }
}