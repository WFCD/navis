DateTime dailyReset() {
  final now = DateTime.timestamp();

  return DateTime.utc(now.year, now.month, now.day, 23, 59, 59, 999).add(const Duration(seconds: 60));
}

DateTime weeklReset() {
  final now = DateTime.timestamp();
  final isMonday = now.day == 0;
  final daysUntilNextMonday = (DateTime.monday - now.weekday + 7) % 7;

  return DateTime.utc(now.year, now.month, now.day + (isMonday ? 7 : daysUntilNextMonday));
}
