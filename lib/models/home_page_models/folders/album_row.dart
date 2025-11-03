import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/album_model.dart';

class AlbumRow extends StatelessWidget {
  final int albumId;

  const AlbumRow({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    final albumType = ListOfAlbums.firstWhere((a) => a.albumId == albumId);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(albumType.albumIconPath, height: 30, width: 30),
            const SizedBox(width: 5),
            Text(
              albumType.albumName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        SvgPicture.asset(
          "lib/assets/other/arrow_next_20px.svg",
          height: 20,
          width: 20,
        ),
      ],
    );
  }
}
