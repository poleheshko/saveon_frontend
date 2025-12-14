import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';
import 'package:saveon_frontend/models/folders/folder_service.dart';

import '../../folders/folder_model.dart';
import 'folder_row.dart';

class FoldersClass extends StatefulWidget {
  const FoldersClass({super.key});

  @override
  State<FoldersClass> createState() => _FoldersClass();
}

class _FoldersClass extends State<FoldersClass> {
  FolderModel? selectedFolder;

  @override
  void initState() {
    super.initState();

    //Fetch folders after first loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FolderService>(context, listen: false).fetchFolders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FolderService>(
        builder: (context, folderService, child) {
          final folders = folderService.folder;
          final foldersCount = folders.length;

          if (folderService.isLoading && folders.isEmpty) {
            return SaveOnSection(
              SaveOnSectionContent: [Center(child: CupertinoActivityIndicator())],
            );
          }

          if (folderService.error != null && folders.isEmpty) {
            return SaveOnSection(
              SaveOnSectionContent: [
                Center(child: Text('Error: ${folderService.error}')),
              ],
            );
          }

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
                        FolderRow(folder: folders[index]),

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
    );
  }
}