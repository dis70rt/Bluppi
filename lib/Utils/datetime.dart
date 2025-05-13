import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimeAgo(Timestamp timestamp) {
  final now = DateTime.now();
  final dateTime = timestamp.toDate();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 5) {
    return 'Just now';
  } else if (difference.inSeconds < 60) {
    return '${difference.inSeconds} sec ago';
  } else if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return '$minutes ${minutes == 1 ? 'min' : 'min'} ago';
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return '$hours ${hours == 1 ? 'hr' : 'hrs'} ago';
  } else if (difference.inDays < 7) {
    final days = difference.inDays;
    return '$days ${days == 1 ? 'day' : 'days'} ago';
  } else if (difference.inDays < 30) {
    final weeks = difference.inDays ~/ 7;
    return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
  } else if (difference.inDays < 365) {
    final months = difference.inDays ~/ 30;
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else {
    final years = difference.inDays ~/ 365;
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  }
}

String formatTrackPlayedAt(Timestamp playedAt) {
  final dateTime = playedAt.toDate();
  final now = DateTime.now();

  final isToday = dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day;

  if (isToday) {
    return DateFormat.jm().format(dateTime);
  } else {
    return DateFormat('d MMMM yyyy').format(dateTime);
  }
}

String formatDate(DateTime date) {
  final day = date.day;
  final month = date.month;
  final year = date.year;

  String daySuffix = 'th';
  if (day == 1 || day == 21 || day == 31) {
    daySuffix = 'st';
  } else if (day == 2 || day == 22) {
    daySuffix = 'nd';
  } else if (day == 3 || day == 23) {
    daySuffix = 'rd';
  }

  const monthNames = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final monthName = monthNames[month];

  return '$day$daySuffix $monthName $year';
}
