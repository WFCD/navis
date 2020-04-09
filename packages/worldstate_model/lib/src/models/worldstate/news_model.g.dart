// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrbiterNewsModel _$OrbiterNewsModelFromJson(Map<String, dynamic> json) {
  return OrbiterNewsModel(
    id: json['id'] as String,
    message: json['message'] as String,
    link: json['link'] as String,
    imageLink: json['imageLink'] as String,
    priority: json['priority'] as bool,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    update: json['update'] as bool,
    primeAccess: json['primeAccess'] as bool,
    stream: json['stream'] as bool,
    translations: (json['translations'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$OrbiterNewsModelToJson(OrbiterNewsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'link': instance.link,
      'imageLink': instance.imageLink,
      'date': instance.date?.toIso8601String(),
      'priority': instance.priority,
      'update': instance.update,
      'primeAccess': instance.primeAccess,
      'stream': instance.stream,
      'translations': instance.translations,
    };
