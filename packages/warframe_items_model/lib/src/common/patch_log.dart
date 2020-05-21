import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patch_log.g.dart';

@JsonSerializable()
class Patchlog extends Equatable {
  const Patchlog({
    this.name,
    this.date,
    this.url,
    this.changes,
    this.fixes,
  });

  factory Patchlog.fromJson(Map<String, dynamic> json) {
    return _$PatchlogFromJson(json);
  }

  final String name, url, changes, fixes;
  final DateTime date;

  Map<String, dynamic> toJson() => _$PatchlogToJson(this);

  @override
  List<Object> get props {
    return [name, date, url, changes, fixes];
  }
}
