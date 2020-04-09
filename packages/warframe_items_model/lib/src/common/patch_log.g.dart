// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patchlog _$PatchlogFromJson(Map<String, dynamic> json) {
  return Patchlog(
    name: json['name'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    url: json['url'] as String,
    changes: json['changes'] as String,
    fixes: json['fixes'] as String,
  );
}

Map<String, dynamic> _$PatchlogToJson(Patchlog instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'changes': instance.changes,
      'fixes': instance.fixes,
      'date': instance.date?.toIso8601String(),
    };
