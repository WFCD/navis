import 'package:warframestat_client/warframestat_client.dart';

DateTime dailyReset() {
  final now = DateTime.timestamp();

  return DateTime.utc(now.year, now.month, now.day, 23, 59, 59, 999).add(const Duration(seconds: 60));
}

DateTime weeklyReset() {
  final now = DateTime.timestamp();
  final isMonday = now.weekday == DateTime.monday;
  final daysUntilNextMonday = (DateTime.monday - now.weekday + DateTime.daysPerWeek) % DateTime.daysPerWeek;

  return DateTime.utc(now.year, now.month, now.day + (isMonday ? 7 : daysUntilNextMonday));
}

({DateTime activation, DateTime expiry, EarthState state}) midrathExpiry() {
  const dayDuration = 32 * 60 * 1000; // 32 minutes
  const nightDuration = 16 * 60 * 1000; // 16 minutes
  const totalDuration = dayDuration + nightDuration;

  final refPoint = DateTime.parse('2025-08-07T16:05:29Z');
  final now = DateTime.timestamp();
  final elapsedInCycle = (now.millisecondsSinceEpoch - refPoint.millisecondsSinceEpoch) % totalDuration;

  var phase = (name: EarthState.night, remaining: totalDuration - elapsedInCycle, duration: nightDuration);
  if (elapsedInCycle < dayDuration) {
    phase = (name: EarthState.day, remaining: dayDuration - elapsedInCycle, duration: dayDuration);
  }

  final activation = now.subtract(Duration(milliseconds: phase.duration - phase.remaining));
  final expiry = activation.add(Duration(milliseconds: phase.duration));

  return (activation: activation, expiry: expiry, state: phase.name);
}
