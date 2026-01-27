// ignore_for_file: public_member_api_docs All values are self explanatory

class UserData {
  UserData({required this.id, required this.avatar, required this.username, required this.masteryRank});

  factory UserData.fromJson(Map<String, dynamic> map) {
    final account = map['account'] as Map<String, dynamic>;

    return UserData(
      id: map['user_id'] as String,
      avatar: map['avatar'] as String,
      username: map['display_name'] as String,
      masteryRank: account['masteryRank'] as int,
    );
  }

  final String id;
  final String avatar;
  final String username;
  final int masteryRank;
}
