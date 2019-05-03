import 'package:codable/codable.dart';

class Earth extends Coding {
  String id;
  DateTime expiry;
  bool isDay, isCetus;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    id = object.decode('id');
    isDay = object.decode('isDay');
    isCetus = object.decode('isCetus') ?? false;
    expiry = DateTime.parse(object.decode('expiry'));

    if (expiry.difference(DateTime.now().toUtc()) <=
        const Duration(seconds: 1)) {
      isDay = !isDay;
      if (isDay)
        expiry = isCetus
            ? expiry.add(const Duration(minutes: 100))
            : expiry.add(const Duration(hours: 4));
      else
        expiry = isCetus
            ? expiry.add(const Duration(minutes: 50))
            : expiry.add(const Duration(hours: 4));
    }
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('id', id);
    object.encode('expiry', expiry);
    object.encode('isCetus', isCetus);
    object.encode('isDay', isDay);
    object.encode('expiry', expiry.toIso8601String());
  }
}
