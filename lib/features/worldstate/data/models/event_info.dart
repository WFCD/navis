import 'package:flutter/foundation.dart';
import 'package:navis/features/worldstate/domain/entities/event_info.dart';

class EventInfoModel extends EventInfo {
  const EventInfoModel({
    @required String keyArt,
    @required List<HowTo> howTos,
  }) : super(keyArt: keyArt, howTos: howTos);

  factory EventInfoModel.fromJson(Map<String, dynamic> json) {
    return EventInfoModel(
      keyArt: json['keyArt'] as String,
      howTos: (json['howTo'] as List<dynamic>)
          ?.map((dynamic h) => HowToModel.fromJson(h as Map<String, dynamic>))
          ?.toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'keyArt': keyArt,
      'howTo': howTos.map((h) => (h as HowToModel).toJson()).toList()
    };
  }
}

class HowToModel extends HowTo {
  const HowToModel({
    @required String id,
    @required String title,
    @required String author,
    @required String pThumbnail,
    @required String link,
  }) : super(
          id: id,
          title: title,
          author: author,
          pThumbnail: pThumbnail,
          link: link,
        );

  factory HowToModel.fromJson(Map<String, dynamic> json) {
    return HowToModel(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      pThumbnail: json['pThumbnail'] as String,
      link: json['link'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'pThumbnail': pThumbnail,
      'link': link,
    };
  }
}
