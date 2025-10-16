import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';

import '../../../data/album_model.dart';

class AlbumSelectorClass extends StatefulWidget {
  final Function(Set<int>)? onAlbumSelected; // ✅ callback, który pózniej przekaże dane do expense page

  const AlbumSelectorClass({super.key, this.onAlbumSelected});

  @override
  State<AlbumSelectorClass> createState() => _AlbumSelectorClassState();
}

class _AlbumSelectorClassState extends State<AlbumSelectorClass> {
  final Set<int> _selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    return SaveOnSection(
      SaveOnSectionContent: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          itemCount: ListOfAlbums.length,
          itemBuilder: (context, index) {
            final bool isSelected = _selectedIndices.contains(index);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  selected: isSelected,

                  // styling part
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -4),
                  minVerticalPadding: 0,
                  horizontalTitleGap: 5,
                  //distance between leading and title
                  selectedColor: Color(0xFF5D52FF),

                  leading: SvgPicture.asset(
                    ListOfAlbums[index].albumIconPath,
                    width: 30,
                    height: 30,
                  ),
                  title: Text(ListOfAlbums[index].albumName),
                  trailing:
                      isSelected
                          ? SvgPicture.asset(
                            "lib/assets/album_icons/item_selected.svg",
                            height: 20,
                            width: 20,
                          )
                          : SvgPicture.asset(
                            "lib/assets/album_icons/item_unselected.svg",
                            height: 20,
                            width: 20,
                          ),
                  onTap: () {
                    setState(() {
                      // Jeśli indeks jest już w zbiorze, usuń go (odznaczanie)
                      if (_selectedIndices.contains(index)) {
                        _selectedIndices.remove(index);
                      }
                      // Jeśli go nie ma, dodaj go (zaznaczanie)
                      else {
                        _selectedIndices.add(index);
                      }

                      // wywołanie callbacku
                      widget.onAlbumSelected?.call(_selectedIndices);
                    });
                  },
                ),

                if (index != ListOfAlbums.length - 1) ...[
                  const SizedBox(height: 10),
                  Container(color: Color(0xFFC0C0C0), height: 0.2),
                  const SizedBox(height: 10),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
