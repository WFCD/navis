import 'package:flutter/cupertino.dart';

class EventInfo {
  final String keyArt;
  final List<HowTo> howTos;

  const EventInfo({@required this.keyArt, @required this.howTos});
}

class HowTo {
  final String id;
  final String title;
  final String author;
  final String pThumbnail;
  final String link;

  const HowTo({
    @required this.id,
    @required this.title,
    @required this.author,
    @required this.pThumbnail,
    @required this.link,
  });
}
