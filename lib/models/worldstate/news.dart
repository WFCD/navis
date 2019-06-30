import 'package:codable/codable.dart';
import 'package:codable/cast.dart' as cast;
import 'package:navis/models/abstract_classes.dart';

class OrbiterNews extends WorldstateObject {
  String message, link, imageLink;
  DateTime date;
  bool priority, update, primeAccess, stream;

  Map<String, String> translations;

  @override
  Map<String, cast.Cast> get castMap =>
      {'translations': const cast.Map(cast.String, cast.String)};

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
    translations = object.decode('translations');
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
    object.encode('translations', translations);
  }

  @override
  List get props => super.props
    ..addAll([message, link, imageLink, date, update, stream, translations]);
}
