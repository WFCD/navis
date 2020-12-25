import 'package:flutter/foundation.dart';

import '../../domain/entities/event_info.dart';

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
    @required String pThumbnail,
  }) : super(
          id: id,
          pThumbnail: pThumbnail,
        );

  factory HowToModel.fromJson(Map<String, dynamic> json) {
    return HowToModel(
      id: json['id'] as String,
      pThumbnail: json['pThumbnail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'pThumbnail': pThumbnail,
    };
  }
}
