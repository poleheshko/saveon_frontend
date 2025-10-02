import 'dart:ui';

class Category {
  final int categoryId;
  final String categoryName;
  final String categoryIconPath;
  final Color labelColor;
  final Color textColor;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryIconPath,
    required this.labelColor,
    required this.textColor
  });
}

List<Category> expenseCategories =[
  Category(
    categoryId: 1,
    categoryName: "Groceries",
    categoryIconPath: "lib/assets/category_icons/category_groceries.svg",
    labelColor: Color(0xFFCEF7CF),
    textColor: Color(0xFF2EB433),
  ),

  Category(
    categoryId: 2,
    categoryName: "Restaurants",
    categoryIconPath: "lib/assets/category_icons/category_restaurants.svg",
    labelColor: Color(0xFFFFDAE9),
    textColor: Color(0xFFE1075E),
  ),
  Category(
    categoryId: 3,
    categoryName: "Transport",
    categoryIconPath: "lib/assets/category_icons/category_transport.svg",
    labelColor: Color(0xFFDCE7FF),
    textColor: Color(0xFF1E64FA),
  ),
  Category(
    categoryId: 4,
    categoryName: "Home",
    categoryIconPath: "lib/assets/category_icons/category_home.svg",
    labelColor: Color(0xFFE9D5C3),
    textColor: Color(0xFF835A34),
  ),
  Category(
    categoryId: 5,
    categoryName: "Purchases",
    categoryIconPath: "lib/assets/category_icons/category_purchases.svg",
    labelColor: Color(0xFFFFD9F0),
    textColor: Color(0xFFFF0099),
  ),
  Category(
    categoryId: 6,
    categoryName: "Subscriptions",
    categoryIconPath: "lib/assets/category_icons/category_subscriptions.svg",
    labelColor: Color(0xFFD8FBF9),
    textColor: Color(0xFF00AFA6),
  ),
  Category(
    categoryId: 7,
    categoryName: "Services",
    categoryIconPath: "lib/assets/category_icons/category_services.svg",
    labelColor: Color(0xFFFFDDDD),
    textColor: Color(0xFFFF2B2B),
  ),
  Category(
    categoryId: 8,
    categoryName: "Events",
    categoryIconPath: "lib/assets/category_icons/category_events.svg",
    labelColor: Color(0xFFFFF0D7),
    textColor: Color(0xFFE58D00),
  ),
  Category(
    categoryId: 9,
    categoryName: "Sport",
    categoryIconPath: "lib/assets/category_icons/category_sport.svg",
    labelColor: Color(0xFFC5EFFF),
    textColor: Color(0xFF00A7E4),
  ),
  Category(
    categoryId: 10,
    categoryName: "Pets",
    categoryIconPath: "lib/assets/category_icons/category_pets.svg",
    labelColor: Color(0xFFE9CFFF),
    textColor: Color(0xFF9543DD),
  ),
  Category(
    categoryId: 11,
    categoryName: "Others",
    categoryIconPath: "lib/assets/category_icons/category_other.svg",
    labelColor: Color(0xFFDADADA),
    textColor: Color(0xFF858585),
  ),

  ];