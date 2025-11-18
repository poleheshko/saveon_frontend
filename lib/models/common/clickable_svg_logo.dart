import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClickableSvgLogo extends StatelessWidget {
  final String SvgPath;
  final Function()? onTap;

  const ClickableSvgLogo({super.key, required this.SvgPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(child: SvgPicture.asset(SvgPath), onTap: onTap);
  }
}
