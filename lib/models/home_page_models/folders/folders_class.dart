import 'package:flutter/cupertino.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';

import '../../../data/album_model.dart';
import 'album_row.dart';

class FoldersClass extends StatefulWidget {
  const FoldersClass({super.key});

  State<FoldersClass> createState() => _FoldersClass();
}

class _FoldersClass extends State<FoldersClass> {
  final foldersCount = 3;

  @override
  Widget build(BuildContext context) {
    return SaveOnSection(
      SaveOnSectionContent: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          itemCount: foldersCount,
          itemBuilder: (context, index) {
            return Column(
              children: [
                AlbumRow(albumId: ListOfAlbums[index].albumId),

                if (index != foldersCount - 1) ...[
                  const SizedBox(height: 10),
                  Container(color: Color(0xFFC0C0C0), height: 0.2),
                  const SizedBox(height: 10),
                ],
              ],
            );
          }
        )
      ],
      sectionTitle: 'Folders',
      textLabelButton: 'Add',
      textButtonOnPressed: () {},
    );
  }
}