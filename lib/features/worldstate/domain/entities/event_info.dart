import 'package:flutter/cupertino.dart';

class EventInfo {
  const EventInfo({@required this.keyArt, @required this.howTos});

  final String keyArt;
  final List<HowTo> howTos;
}

class HowTo {
  const HowTo({
    @required this.id,
    @required this.title,
    @required this.author,
    @required this.pThumbnail,
    @required this.link,
  });

  final String id;
  final String title;
  final String author;
  final String pThumbnail;
  final String link;
}
