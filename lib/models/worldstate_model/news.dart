import 'package:codable/codable.dart';

class OrbiterNews extends Coding {
  String message, link, imageLink, date;
  bool update, stream;

  _Translations translations;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    message = object.decode('message');
    link = object.decode('link');
    imageLink = object.decode('imageLink');
    date = object.decode('date');
    update = object.decode('update');
    stream = object.decode('stream');
    translations = object.decodeObject('translations', () => _Translations());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('message', message);
    object.encode('link', link);
    object.encode('imageLink', imageLink);
    object.encode('date', date);
    object.encode('update', update);
    object.encode('stream', stream);
    object.encode('translations', translations);
  }
}

class _Translations extends Coding {
  String en;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    en = object.decode('en');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('en', en);
  }
}
