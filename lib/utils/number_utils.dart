import 'package:intl/intl.dart';

class SaveOnNumberUtils {

  /// Formats a number to show with thousand separators and two decimal places
  /// Example: 1234.5 -> "1,234.50", 1234567.89 -> "1,234,567.89"
  static String formatCurrency(double number) {
    final NumberFormat formatter = NumberFormat('#,##0.00');
    return formatter.format(number);
  }
}