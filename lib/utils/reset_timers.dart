DateTime dailyReset() {
  final now = DateTime.timestamp();

  return DateTime.utc(now.year, now.month, now.day, 23, 59, 59, 999).add(const Duration(seconds: 60));
}

DateTime weeklReset() {
  final now = DateTime.timestamp();
  final isMonday = now.weekday == DateTime.monday;
  final daysUntilNextMonday = (DateTime.monday - now.weekday + DateTime.daysPerWeek) % DateTime.daysPerWeek;

  return DateTime.utc(now.year, now.month, now.day + (isMonday ? 7 : daysUntilNextMonday));
}
