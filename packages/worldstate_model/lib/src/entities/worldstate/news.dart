import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

class OrbiterNews extends WorldstateObject {
  const OrbiterNews({
    String id,
    this.message,
    this.link,
    this.imageLink,
    this.priority,
    this.date,
    this.update,
    this.primeAccess,
    this.stream,
    this.translations,
  }) : super(id: id);

  final String message, link, imageLink;
  final DateTime date;
  final bool priority, update, primeAccess, stream;

  final Map<String, String> translations;

  /// Uses warframestat image proxy to export a webp version of the image
  String get proxyImage {
    final encoded = Uri.encodeFull(imageLink);

    return 'https://cdn.warframestat.us/o_webp,progressive_false/$encoded';
  }

  /// create an elapsed time using [OrbiterNews.date]
  String get timestamp {
    final Duration duration = date.toLocal().difference(DateTime.now()).abs();

    const Duration hour = Duration(hours: 1);
    const Duration day = Duration(hours: 24);

    if (duration < hour) {
      return '${duration.inMinutes.floor()}m';
    } else if (duration >= hour && duration < day) {
      return '${duration.inHours.floor()}h ${(duration.inMinutes % 60).floor()}m';
    } else {
      return '${duration.inDays.floor()}d';
    }
  }

  @override
  List<Object> get props {
    return super.props
      ..addAll([
        message,
        link,
        imageLink,
        date,
        priority,
        update,
        primeAccess,
        stream,
        translations
      ]);
  }
}
