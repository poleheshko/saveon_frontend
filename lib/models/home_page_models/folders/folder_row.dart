import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/folders/folder_model.dart';

import '../../folders/folder_service.dart';

class FolderRow extends StatelessWidget {
  final int? folderId;
  final FolderModel? folder;

  const FolderRow({super.key, this.folderId, this.folder})
    : assert(
        folderId != null || folder != null,
        'Either folderId or folder must be provided',
  );

  @override
  Widget build(BuildContext context) {
    // if folder has been provided we use those data directly
    if (folder != null) {
      return _buildAlbumRow(context, folder!);
    }

    return Consumer<FolderService>(
      builder: (context, folderService, child) {
        final folders = folderService.folder;

        try {
          final foundFolder = folders.firstWhere(
                (c) => c.folderId == folderId,
          );
          return _buildAlbumRow(context, foundFolder);
        } catch (e) {
          // Jeśli nie znaleziono, zwróć placeholder
          return SizedBox(
            width: double.infinity,
            child: Text(
              'Category not found',
              style: TextStyle(color: CupertinoColors.systemGrey),
            ),
          );
        }
      },
    );
  }

  Widget _buildAlbumRow(BuildContext context, FolderModel folder) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(folder.folderIconPath, height: 30, width: 30),
            const SizedBox(width: 5),
            Text(
              folder.folderName,
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
