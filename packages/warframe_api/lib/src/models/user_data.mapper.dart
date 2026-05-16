// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_data.dart';

class UserDataMapper extends ClassMapperBase<UserData> {
  UserDataMapper._();

  static UserDataMapper? _instance;
  static UserDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserDataMapper._());
      UserAccountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserData';

  static String _$id(UserData v) => v.id;
  static const Field<UserData, String> _f$id = Field(
    'id',
    _$id,
    key: r'user_id',
  );
  static String _$username(UserData v) => v.username;
  static const Field<UserData, String> _f$username = Field(
    'username',
    _$username,
    key: r'display_name',
  );
  static String _$avatar(UserData v) => v.avatar;
  static const Field<UserData, String> _f$avatar = Field('avatar', _$avatar);
  static UserAccount _$account(UserData v) => v.account;
  static const Field<UserData, UserAccount> _f$account = Field(
    'account',
    _$account,
  );

  @override
  final MappableFields<UserData> fields = const {
    #id: _f$id,
    #username: _f$username,
    #avatar: _f$avatar,
    #account: _f$account,
  };

  static UserData _instantiate(DecodingData data) {
    return UserData(
      id: data.dec(_f$id),
      username: data.dec(_f$username),
      avatar: data.dec(_f$avatar),
      account: data.dec(_f$account),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserData>(map);
  }

  static UserData fromJson(String json) {
    return ensureInitialized().decodeJson<UserData>(json);
  }
}

mixin UserDataMappable {
  String toJson() {
    return UserDataMapper.ensureInitialized().encodeJson<UserData>(
      this as UserData,
    );
  }

  Map<String, dynamic> toMap() {
    return UserDataMapper.ensureInitialized().encodeMap<UserData>(
      this as UserData,
    );
  }

  UserDataCopyWith<UserData, UserData, UserData> get copyWith =>
      _UserDataCopyWithImpl<UserData, UserData>(
        this as UserData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserDataMapper.ensureInitialized().stringifyValue(this as UserData);
  }

  @override
  bool operator ==(Object other) {
    return UserDataMapper.ensureInitialized().equalsValue(
      this as UserData,
      other,
    );
  }

  @override
  int get hashCode {
    return UserDataMapper.ensureInitialized().hashValue(this as UserData);
  }
}

extension UserDataValueCopy<$R, $Out> on ObjectCopyWith<$R, UserData, $Out> {
  UserDataCopyWith<$R, UserData, $Out> get $asUserData =>
      $base.as((v, t, t2) => _UserDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserDataCopyWith<$R, $In extends UserData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  UserAccountCopyWith<$R, UserAccount, UserAccount> get account;
  $R call({String? id, String? username, String? avatar, UserAccount? account});
  UserDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserData, $Out>
    implements UserDataCopyWith<$R, UserData, $Out> {
  _UserDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserData> $mapper =
      UserDataMapper.ensureInitialized();
  @override
  UserAccountCopyWith<$R, UserAccount, UserAccount> get account =>
      $value.account.copyWith.$chain((v) => call(account: v));
  @override
  $R call({
    String? id,
    String? username,
    String? avatar,
    UserAccount? account,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (username != null) #username: username,
      if (avatar != null) #avatar: avatar,
      if (account != null) #account: account,
    }),
  );
  @override
  UserData $make(CopyWithData data) => UserData(
    id: data.get(#id, or: $value.id),
    username: data.get(#username, or: $value.username),
    avatar: data.get(#avatar, or: $value.avatar),
    account: data.get(#account, or: $value.account),
  );

  @override
  UserDataCopyWith<$R2, UserData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserAccountMapper extends ClassMapperBase<UserAccount> {
  UserAccountMapper._();

  static UserAccountMapper? _instance;
  static UserAccountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserAccountMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserAccount';

  static String _$platform(UserAccount v) => v.platform;
  static const Field<UserAccount, String> _f$platform = Field(
    'platform',
    _$platform,
    key: r'game_platform',
  );
  static int _$masteryRank(UserAccount v) => v.masteryRank;
  static const Field<UserAccount, int> _f$masteryRank = Field(
    'masteryRank',
    _$masteryRank,
  );

  @override
  final MappableFields<UserAccount> fields = const {
    #platform: _f$platform,
    #masteryRank: _f$masteryRank,
  };

  static UserAccount _instantiate(DecodingData data) {
    return UserAccount(
      platform: data.dec(_f$platform),
      masteryRank: data.dec(_f$masteryRank),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserAccount fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserAccount>(map);
  }

  static UserAccount fromJson(String json) {
    return ensureInitialized().decodeJson<UserAccount>(json);
  }
}

mixin UserAccountMappable {
  String toJson() {
    return UserAccountMapper.ensureInitialized().encodeJson<UserAccount>(
      this as UserAccount,
    );
  }

  Map<String, dynamic> toMap() {
    return UserAccountMapper.ensureInitialized().encodeMap<UserAccount>(
      this as UserAccount,
    );
  }

  UserAccountCopyWith<UserAccount, UserAccount, UserAccount> get copyWith =>
      _UserAccountCopyWithImpl<UserAccount, UserAccount>(
        this as UserAccount,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserAccountMapper.ensureInitialized().stringifyValue(
      this as UserAccount,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserAccountMapper.ensureInitialized().equalsValue(
      this as UserAccount,
      other,
    );
  }

  @override
  int get hashCode {
    return UserAccountMapper.ensureInitialized().hashValue(this as UserAccount);
  }
}

extension UserAccountValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserAccount, $Out> {
  UserAccountCopyWith<$R, UserAccount, $Out> get $asUserAccount =>
      $base.as((v, t, t2) => _UserAccountCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserAccountCopyWith<$R, $In extends UserAccount, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? platform, int? masteryRank});
  UserAccountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserAccountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserAccount, $Out>
    implements UserAccountCopyWith<$R, UserAccount, $Out> {
  _UserAccountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserAccount> $mapper =
      UserAccountMapper.ensureInitialized();
  @override
  $R call({String? platform, int? masteryRank}) => $apply(
    FieldCopyWithData({
      if (platform != null) #platform: platform,
      if (masteryRank != null) #masteryRank: masteryRank,
    }),
  );
  @override
  UserAccount $make(CopyWithData data) => UserAccount(
    platform: data.get(#platform, or: $value.platform),
    masteryRank: data.get(#masteryRank, or: $value.masteryRank),
  );

  @override
  UserAccountCopyWith<$R2, UserAccount, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserAccountCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

