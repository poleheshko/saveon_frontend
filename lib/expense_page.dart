import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'models/common/common_page.dart';
import 'models/common/saveon_section.dart';
import 'models/expense_categories/category_row_prefab.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key, required this.title});

  final String title;

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    return CommonPage(
      commonPageContent: [
        SizedBox(width: double.infinity, height: 100),
        SaveOnSection(
          SaveOnSectionContent: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "lib/assets/category_icons/category_notSelected.svg",
                    ),
                    SizedBox(width: 10),
                    const Text("Category"),
                  ],
                ),
                SvgPicture.asset("lib/assets/other/hamburger_icon.svg"),
              ],
            ),
          ],
        ),
        SizedBox(height: 20,),
        SaveOnSection(
          SaveOnSectionContent: [
            CategoryRowPrefab(categoryId: 1),
          ],
        ),
        SizedBox(height: 20,),
        SaveOnSection(
          SaveOnSectionContent: [
            CategoryRowPrefab(categoryId: 2),
          ],
        ),
        SizedBox(height: 20,),
        SaveOnSection(
          SaveOnSectionContent: [
            CategoryRowPrefab(categoryId: 3),
          ],
        ),
        SizedBox(height: 20,),
        SaveOnSection(
          SaveOnSectionContent: [
            CategoryRowPrefab(categoryId: 4),
          ],
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
