import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';

import 'album_row.dart';

class AlbumSelectorClass extends StatefulWidget {
  const AlbumSelectorClass({super.key});

  @override
  State<AlbumSelectorClass> createState() => _AlbumSelectorClassState();
}

class _AlbumSelectorClassState extends State<AlbumSelectorClass> {
  @override
  Widget build(BuildContext context) {
    return SaveOnSection(
      SaveOnSectionContent: [
        AlbumRow()
      ],
    );
  }
}
