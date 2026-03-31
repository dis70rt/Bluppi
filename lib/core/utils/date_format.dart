String formatTimeAgo(DateTime? date) {
  if (date == null) return '';

  final diff = DateTime.now().difference(date);
  if (diff.inDays >= 365) {
    return '${(diff.inDays / 365).floor()}y';
  } else if (diff.inDays >= 30) {
    return '${(diff.inDays / 30).floor()}mo';
  } else if (diff.inDays > 0) {
    return '${diff.inDays}d';
  } else if (diff.inHours > 0) {
    return '${diff.inHours}h';
  } else if (diff.inMinutes > 0) {
    return '${diff.inMinutes}m';
  }
  return 'Just now';
}
