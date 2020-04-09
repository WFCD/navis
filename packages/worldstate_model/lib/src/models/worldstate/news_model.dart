import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/news.dart';

part 'news_model.g.dart';

@JsonSerializable()
class OrbiterNewsModel extends OrbiterNews {
  const OrbiterNewsModel({
    String id,
    String message,
    String link,
    String imageLink,
    bool priority,
    DateTime date,
    bool update,
    bool primeAccess,
    bool stream,
    Map<String, String> translations,
  }) : super(
          id: id,
          message: message,
          link: link,
          imageLink: imageLink,
          priority: priority,
          date: date,
          update: update,
          primeAccess: primeAccess,
          stream: stream,
          translations: translations,
        );

  factory OrbiterNewsModel.fromJson(Map<String, dynamic> json) {
    return _$OrbiterNewsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrbiterNewsModelToJson(this);
}
