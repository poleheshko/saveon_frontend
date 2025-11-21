import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonPageEmpty extends StatelessWidget {
  final List<Widget> commonPageEmptyContent;

  const CommonPageEmpty({required this.commonPageEmptyContent, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: commonPageEmptyContent,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
