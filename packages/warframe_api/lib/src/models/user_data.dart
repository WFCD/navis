import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';

part 'user_data.mapper.dart';

@MappableClass()
class UserData with UserDataMappable {
  UserData({required this.id, required this.username, required this.avatar, required this.account});

  factory UserData.raw(String json) {
    return UserData.fromJson(const LineSplitter().convert(json).join());
  }

  static const fromJson = UserDataMapper.fromJson;
  static const fromMap = UserDataMapper.fromMap;

  @MappableField(key: 'user_id')
  final String id;

  @MappableField(key: 'display_name')
  final String username;

  final String avatar;

  final UserAccount account;
}

@MappableClass()
class UserAccount with UserAccountMappable {
  UserAccount({required this.platform, required this.masteryRank});

  static const fromJson = UserAccountMapper.fromJson;
  static const fromMap = UserAccountMapper.fromMap;

  @MappableField(key: 'game_platform')
  final String platform;

  final int masteryRank;
}
