import 'package:json_annotation/json_annotation.dart';

part 'drop_table_info.g.dart';

@JsonSerializable()
class Info {
  Info(this.hash, this.timestampInMilliseconds, this.modifiedInMilliseconds);

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  /// An MD5 hash generated from the drop data page.
  final String hash;

  final int timestampInMilliseconds, modifiedInMilliseconds;

  /// The timestamp at which the build was generated WFCD.
  DateTime get timestamp =>
      DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);

  /// The timestamp at which the drop data page was last modified by DE.
  DateTime get modified =>
      DateTime.fromMillisecondsSinceEpoch(modifiedInMilliseconds);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
