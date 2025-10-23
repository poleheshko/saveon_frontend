import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';

import 'album_row.dart';

class FoldersClass extends StatefulWidget {
  const FoldersClass({super.key});

  State<FoldersClass> createState() => _FoldersClass();
}

class _FoldersClass extends State<FoldersClass> {
  @override
  Widget build(BuildContext context) {
    return SaveOnSection(SaveOnSectionContent: [
      AlbumRow(
        albumId: 0,
      )
    ]);
  }
}