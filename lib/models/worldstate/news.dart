import 'package:codable/codable.dart';
import 'package:navis/models/abstract_classes.dart';

class OrbiterNews extends WorldstateObject {
  String message, link, imageLink;
  DateTime date;
  bool priority, update, primeAccess, stream;

  _Translations translations;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    message = object.decode('message');
    link = object.decode('link');
    imageLink = object.decode('imageLink');
    priority = object.decode('priority');
    date = DateTime.parse(object.decode('date'));
    update = object.decode('update');
    primeAccess = object.decode('primeAccess');
    stream = object.decode('stream');
    translations = object.decodeObject('translations', () => _Translations());
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('message', message);
    object.encode('link', link);
    object.encode('imageLink', imageLink);
    object.encode('date', date);
    object.encode('update', update);
    object.encode('stream', stream);
    object.encodeObject('translations', translations);
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
