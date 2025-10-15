import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/category_info.dart';
import '../../common/saveon_section.dart';
import 'category_label_prefab.dart';
import 'category_row_prefab.dart';

class ChooseCategoryClass extends StatefulWidget {
  final Function(Category)? onCategorySelected; // ✅ callback, który pózniej przekaże dane do expense page

  const ChooseCategoryClass({super.key, this.onCategorySelected});

  State<ChooseCategoryClass> createState() => _ChooseCategoryClassState();
}

class _ChooseCategoryClassState extends State<ChooseCategoryClass> {
  bool showCategories = false;
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SaveOnSection(
      SaveOnSectionContent: [
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();

            setState(() {
              showCategories = !showCategories;
            });
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              selectedCategory == null
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "lib/assets/category_icons/category_notSelected.svg",
                      ),
                      SizedBox(width: 10),
                      const Text(
                        "choose category",
                        style: TextStyle(
                          color: Color(0xFF959595),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                  : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(selectedCategory!.categoryIconPath),
                      SizedBox(width: 10),
                      CategoryLabelPrefab(
                        categoryName: selectedCategory!.categoryName,
                        categoryLabelColor: selectedCategory!.labelColor,
                        categoryTextColor: selectedCategory!.textColor,
                      ),
                    ],
                  ),

              //hamburger icon button
              GestureDetector(
                onTap: () {
                  setState(() {
                    showCategories = !showCategories;
                  });
                },
                child: SvgPicture.asset("lib/assets/other/hamburger_icon.svg"),
              ),
            ],
          ),
        ),

        if (showCategories) ...[
          for (final category in ListExpenseCategories) ...[
            //pojedynczy przycisk categorii
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              // wykrywa kliknięcie też na pustych miejscach
              onTap: () {
                setState(() {
                  showCategories = !showCategories;
                  selectedCategory = category;
                });

                widget.onCategorySelected?.call(category); // wywołuję callback z wybraną kategorią
              },
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(color: Color(0xFFC0C0C0), height: 0.2),
                  const SizedBox(height: 10),
                  CategoryRowPrefab(categoryId: category.categoryId),
                ],
              ),
            ),
          ],
        ],
      ],
    );
  }
}
