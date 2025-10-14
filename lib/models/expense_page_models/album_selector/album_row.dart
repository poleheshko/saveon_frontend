import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumRow extends StatefulWidget {
  const AlbumRow({super.key});

  @override
  State<StatefulWidget> createState() => _AlbumRowState();
}

class _AlbumRowState extends State<AlbumRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(height: 50, width: 50, color: Colors.amber)
      ]
    );
  }
}