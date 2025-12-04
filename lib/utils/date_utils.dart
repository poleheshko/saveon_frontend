import 'package:intl/intl.dart';

/// Utility class for date formatting and manipulation

class SaveOnDateUtils {
  /// Formats a DateTime to 'dd.MM.yyyy' format
  /// Example: 2024-01-15 -> "15.01.2024"
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(date);
  }

  /// Formats a DateTime to 'dd.MM.yyyy HH:mm' format
  /// Example: 2024-01-15 14:30 -> "14:30"
  static String formatDateTime(DateTime date) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm');
    return formatter.format(date);
  }

  /// Formats a DateTime to show only time in 'HH:mm' format
  /// Example: 2024-01-15 14:30 -> "14:30"
  static String formatTime(DateTime date) {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(date);
  }

  /// Formats a DateTime to display relative time (e.g., "Today", "Yesterday", "2 days ago")
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    final difference = today.difference(dateOnly).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '$difference days ago';

    return formatDate(date);
  }

  /// Returns a DateTime with only the date part (time set to 00:00:00)
  static DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}