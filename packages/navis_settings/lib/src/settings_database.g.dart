// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_database.dart';

// ignore_for_file: type=lint
class $AppConfigsTable extends AppConfigs
    with TableInfo<$AppConfigsTable, AppConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<int> theme = GeneratedColumn<int>(
    'theme',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(ThemeMode.system.index),
  );
  static const VerificationMeta _optOutMeta = const VerificationMeta('optOut');
  @override
  late final GeneratedColumn<bool> optOut = GeneratedColumn<bool>(
    'opt_out',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("opt_out" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _accountMeta = const VerificationMeta(
    'account',
  );
  @override
  late final GeneratedColumn<String> account = GeneratedColumn<String>(
    'account',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, language, theme, optOut, account];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('theme')) {
      context.handle(
        _themeMeta,
        theme.isAcceptableOrUnknown(data['theme']!, _themeMeta),
      );
    }
    if (data.containsKey('opt_out')) {
      context.handle(
        _optOutMeta,
        optOut.isAcceptableOrUnknown(data['opt_out']!, _optOutMeta),
      );
    }
    if (data.containsKey('account')) {
      context.handle(
        _accountMeta,
        account.isAcceptableOrUnknown(data['account']!, _accountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      theme: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}theme'],
      )!,
      optOut: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}opt_out'],
      )!,
      account: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account'],
      ),
    );
  }

  @override
  $AppConfigsTable createAlias(String alias) {
    return $AppConfigsTable(attachedDatabase, alias);
  }
}

class AppConfig extends DataClass implements Insertable<AppConfig> {
  final int id;
  final String language;
  final int theme;
  final bool optOut;
  final String? account;
  const AppConfig({
    required this.id,
    required this.language,
    required this.theme,
    required this.optOut,
    this.account,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<String>(language);
    map['theme'] = Variable<int>(theme);
    map['opt_out'] = Variable<bool>(optOut);
    if (!nullToAbsent || account != null) {
      map['account'] = Variable<String>(account);
    }
    return map;
  }

  AppConfigsCompanion toCompanion(bool nullToAbsent) {
    return AppConfigsCompanion(
      id: Value(id),
      language: Value(language),
      theme: Value(theme),
      optOut: Value(optOut),
      account: account == null && nullToAbsent
          ? const Value.absent()
          : Value(account),
    );
  }

  factory AppConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppConfig(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<String>(json['language']),
      theme: serializer.fromJson<int>(json['theme']),
      optOut: serializer.fromJson<bool>(json['optOut']),
      account: serializer.fromJson<String?>(json['account']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<String>(language),
      'theme': serializer.toJson<int>(theme),
      'optOut': serializer.toJson<bool>(optOut),
      'account': serializer.toJson<String?>(account),
    };
  }

  AppConfig copyWith({
    int? id,
    String? language,
    int? theme,
    bool? optOut,
    Value<String?> account = const Value.absent(),
  }) => AppConfig(
    id: id ?? this.id,
    language: language ?? this.language,
    theme: theme ?? this.theme,
    optOut: optOut ?? this.optOut,
    account: account.present ? account.value : this.account,
  );
  AppConfig copyWithCompanion(AppConfigsCompanion data) {
    return AppConfig(
      id: data.id.present ? data.id.value : this.id,
      language: data.language.present ? data.language.value : this.language,
      theme: data.theme.present ? data.theme.value : this.theme,
      optOut: data.optOut.present ? data.optOut.value : this.optOut,
      account: data.account.present ? data.account.value : this.account,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppConfig(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('theme: $theme, ')
          ..write('optOut: $optOut, ')
          ..write('account: $account')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language, theme, optOut, account);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppConfig &&
          other.id == this.id &&
          other.language == this.language &&
          other.theme == this.theme &&
          other.optOut == this.optOut &&
          other.account == this.account);
}

class AppConfigsCompanion extends UpdateCompanion<AppConfig> {
  final Value<int> id;
  final Value<String> language;
  final Value<int> theme;
  final Value<bool> optOut;
  final Value<String?> account;
  const AppConfigsCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.theme = const Value.absent(),
    this.optOut = const Value.absent(),
    this.account = const Value.absent(),
  });
  AppConfigsCompanion.insert({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.theme = const Value.absent(),
    this.optOut = const Value.absent(),
    this.account = const Value.absent(),
  });
  static Insertable<AppConfig> custom({
    Expression<int>? id,
    Expression<String>? language,
    Expression<int>? theme,
    Expression<bool>? optOut,
    Expression<String>? account,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (theme != null) 'theme': theme,
      if (optOut != null) 'opt_out': optOut,
      if (account != null) 'account': account,
    });
  }

  AppConfigsCompanion copyWith({
    Value<int>? id,
    Value<String>? language,
    Value<int>? theme,
    Value<bool>? optOut,
    Value<String?>? account,
  }) {
    return AppConfigsCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      optOut: optOut ?? this.optOut,
      account: account ?? this.account,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (theme.present) {
      map['theme'] = Variable<int>(theme.value);
    }
    if (optOut.present) {
      map['opt_out'] = Variable<bool>(optOut.value);
    }
    if (account.present) {
      map['account'] = Variable<String>(account.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppConfigsCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('theme: $theme, ')
          ..write('optOut: $optOut, ')
          ..write('account: $account')
          ..write(')'))
        .toString();
  }
}

class $ToggleSettingsTable extends ToggleSettings
    with TableInfo<$ToggleSettingsTable, ToggleSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ToggleSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _enableGiftAlertsMeta = const VerificationMeta(
    'enableGiftAlerts',
  );
  @override
  late final GeneratedColumn<bool> enableGiftAlerts = GeneratedColumn<bool>(
    'enable_gift_alerts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_gift_alerts" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _enableOperationAlertsMeta =
      const VerificationMeta('enableOperationAlerts');
  @override
  late final GeneratedColumn<bool> enableOperationAlerts =
      GeneratedColumn<bool>(
        'enable_operation_alerts',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enable_operation_alerts" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _enableBaroAlertsMeta = const VerificationMeta(
    'enableBaroAlerts',
  );
  @override
  late final GeneratedColumn<bool> enableBaroAlerts = GeneratedColumn<bool>(
    'enable_baro_alerts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_baro_alerts" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _enableDarvoAlertsMeta = const VerificationMeta(
    'enableDarvoAlerts',
  );
  @override
  late final GeneratedColumn<bool> enableDarvoAlerts = GeneratedColumn<bool>(
    'enable_darvo_alerts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_darvo_alerts" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _enableSorieAlertsMeta = const VerificationMeta(
    'enableSorieAlerts',
  );
  @override
  late final GeneratedColumn<bool> enableSorieAlerts = GeneratedColumn<bool>(
    'enable_sorie_alerts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_sorie_alerts" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _enableArchonAlertsMeta =
      const VerificationMeta('enableArchonAlerts');
  @override
  late final GeneratedColumn<bool> enableArchonAlerts = GeneratedColumn<bool>(
    'enable_archon_alerts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_archon_alerts" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _enablePrimeAccessMeta = const VerificationMeta(
    'enablePrimeAccess',
  );
  @override
  late final GeneratedColumn<bool> enablePrimeAccess = GeneratedColumn<bool>(
    'enable_prime_access',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_prime_access" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _enableStreamsMeta = const VerificationMeta(
    'enableStreams',
  );
  @override
  late final GeneratedColumn<bool> enableStreams = GeneratedColumn<bool>(
    'enable_streams',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_streams" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _enableUpdatesMeta = const VerificationMeta(
    'enableUpdates',
  );
  @override
  late final GeneratedColumn<bool> enableUpdates = GeneratedColumn<bool>(
    'enable_updates',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_updates" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _settingsIdMeta = const VerificationMeta(
    'settingsId',
  );
  @override
  late final GeneratedColumn<int> settingsId = GeneratedColumn<int>(
    'settings_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_configs (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    enableGiftAlerts,
    enableOperationAlerts,
    enableBaroAlerts,
    enableDarvoAlerts,
    enableSorieAlerts,
    enableArchonAlerts,
    enablePrimeAccess,
    enableStreams,
    enableUpdates,
    settingsId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'toggle_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ToggleSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('enable_gift_alerts')) {
      context.handle(
        _enableGiftAlertsMeta,
        enableGiftAlerts.isAcceptableOrUnknown(
          data['enable_gift_alerts']!,
          _enableGiftAlertsMeta,
        ),
      );
    }
    if (data.containsKey('enable_operation_alerts')) {
      context.handle(
        _enableOperationAlertsMeta,
        enableOperationAlerts.isAcceptableOrUnknown(
          data['enable_operation_alerts']!,
          _enableOperationAlertsMeta,
        ),
      );
    }
    if (data.containsKey('enable_baro_alerts')) {
      context.handle(
        _enableBaroAlertsMeta,
        enableBaroAlerts.isAcceptableOrUnknown(
          data['enable_baro_alerts']!,
          _enableBaroAlertsMeta,
        ),
      );
    }
    if (data.containsKey('enable_darvo_alerts')) {
      context.handle(
        _enableDarvoAlertsMeta,
        enableDarvoAlerts.isAcceptableOrUnknown(
          data['enable_darvo_alerts']!,
          _enableDarvoAlertsMeta,
        ),
      );
    }
    if (data.containsKey('enable_sorie_alerts')) {
      context.handle(
        _enableSorieAlertsMeta,
        enableSorieAlerts.isAcceptableOrUnknown(
          data['enable_sorie_alerts']!,
          _enableSorieAlertsMeta,
        ),
      );
    }
    if (data.containsKey('enable_archon_alerts')) {
      context.handle(
        _enableArchonAlertsMeta,
        enableArchonAlerts.isAcceptableOrUnknown(
          data['enable_archon_alerts']!,
          _enableArchonAlertsMeta,
        ),
      );
    }
    if (data.containsKey('enable_prime_access')) {
      context.handle(
        _enablePrimeAccessMeta,
        enablePrimeAccess.isAcceptableOrUnknown(
          data['enable_prime_access']!,
          _enablePrimeAccessMeta,
        ),
      );
    }
    if (data.containsKey('enable_streams')) {
      context.handle(
        _enableStreamsMeta,
        enableStreams.isAcceptableOrUnknown(
          data['enable_streams']!,
          _enableStreamsMeta,
        ),
      );
    }
    if (data.containsKey('enable_updates')) {
      context.handle(
        _enableUpdatesMeta,
        enableUpdates.isAcceptableOrUnknown(
          data['enable_updates']!,
          _enableUpdatesMeta,
        ),
      );
    }
    if (data.containsKey('settings_id')) {
      context.handle(
        _settingsIdMeta,
        settingsId.isAcceptableOrUnknown(data['settings_id']!, _settingsIdMeta),
      );
    } else if (isInserting) {
      context.missing(_settingsIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ToggleSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ToggleSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      enableGiftAlerts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_gift_alerts'],
      )!,
      enableOperationAlerts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_operation_alerts'],
      )!,
      enableBaroAlerts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_baro_alerts'],
      )!,
      enableDarvoAlerts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_darvo_alerts'],
      )!,
      enableSorieAlerts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_sorie_alerts'],
      )!,
      enableArchonAlerts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_archon_alerts'],
      )!,
      enablePrimeAccess: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_prime_access'],
      )!,
      enableStreams: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_streams'],
      )!,
      enableUpdates: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_updates'],
      )!,
      settingsId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}settings_id'],
      )!,
    );
  }

  @override
  $ToggleSettingsTable createAlias(String alias) {
    return $ToggleSettingsTable(attachedDatabase, alias);
  }
}

class ToggleSetting extends DataClass implements Insertable<ToggleSetting> {
  final int id;

  /// Alerts
  final bool enableGiftAlerts;
  final bool enableOperationAlerts;

  /// Baro Ki'Teer
  final bool enableBaroAlerts;

  /// Weekly and daily stuff
  final bool enableDarvoAlerts;
  final bool enableSorieAlerts;
  final bool enableArchonAlerts;

  /// Warframe news and stream announcements
  final bool enablePrimeAccess;
  final bool enableStreams;
  final bool enableUpdates;
  final int settingsId;
  const ToggleSetting({
    required this.id,
    required this.enableGiftAlerts,
    required this.enableOperationAlerts,
    required this.enableBaroAlerts,
    required this.enableDarvoAlerts,
    required this.enableSorieAlerts,
    required this.enableArchonAlerts,
    required this.enablePrimeAccess,
    required this.enableStreams,
    required this.enableUpdates,
    required this.settingsId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['enable_gift_alerts'] = Variable<bool>(enableGiftAlerts);
    map['enable_operation_alerts'] = Variable<bool>(enableOperationAlerts);
    map['enable_baro_alerts'] = Variable<bool>(enableBaroAlerts);
    map['enable_darvo_alerts'] = Variable<bool>(enableDarvoAlerts);
    map['enable_sorie_alerts'] = Variable<bool>(enableSorieAlerts);
    map['enable_archon_alerts'] = Variable<bool>(enableArchonAlerts);
    map['enable_prime_access'] = Variable<bool>(enablePrimeAccess);
    map['enable_streams'] = Variable<bool>(enableStreams);
    map['enable_updates'] = Variable<bool>(enableUpdates);
    map['settings_id'] = Variable<int>(settingsId);
    return map;
  }

  ToggleSettingsCompanion toCompanion(bool nullToAbsent) {
    return ToggleSettingsCompanion(
      id: Value(id),
      enableGiftAlerts: Value(enableGiftAlerts),
      enableOperationAlerts: Value(enableOperationAlerts),
      enableBaroAlerts: Value(enableBaroAlerts),
      enableDarvoAlerts: Value(enableDarvoAlerts),
      enableSorieAlerts: Value(enableSorieAlerts),
      enableArchonAlerts: Value(enableArchonAlerts),
      enablePrimeAccess: Value(enablePrimeAccess),
      enableStreams: Value(enableStreams),
      enableUpdates: Value(enableUpdates),
      settingsId: Value(settingsId),
    );
  }

  factory ToggleSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ToggleSetting(
      id: serializer.fromJson<int>(json['id']),
      enableGiftAlerts: serializer.fromJson<bool>(json['enableGiftAlerts']),
      enableOperationAlerts: serializer.fromJson<bool>(
        json['enableOperationAlerts'],
      ),
      enableBaroAlerts: serializer.fromJson<bool>(json['enableBaroAlerts']),
      enableDarvoAlerts: serializer.fromJson<bool>(json['enableDarvoAlerts']),
      enableSorieAlerts: serializer.fromJson<bool>(json['enableSorieAlerts']),
      enableArchonAlerts: serializer.fromJson<bool>(json['enableArchonAlerts']),
      enablePrimeAccess: serializer.fromJson<bool>(json['enablePrimeAccess']),
      enableStreams: serializer.fromJson<bool>(json['enableStreams']),
      enableUpdates: serializer.fromJson<bool>(json['enableUpdates']),
      settingsId: serializer.fromJson<int>(json['settingsId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'enableGiftAlerts': serializer.toJson<bool>(enableGiftAlerts),
      'enableOperationAlerts': serializer.toJson<bool>(enableOperationAlerts),
      'enableBaroAlerts': serializer.toJson<bool>(enableBaroAlerts),
      'enableDarvoAlerts': serializer.toJson<bool>(enableDarvoAlerts),
      'enableSorieAlerts': serializer.toJson<bool>(enableSorieAlerts),
      'enableArchonAlerts': serializer.toJson<bool>(enableArchonAlerts),
      'enablePrimeAccess': serializer.toJson<bool>(enablePrimeAccess),
      'enableStreams': serializer.toJson<bool>(enableStreams),
      'enableUpdates': serializer.toJson<bool>(enableUpdates),
      'settingsId': serializer.toJson<int>(settingsId),
    };
  }

  ToggleSetting copyWith({
    int? id,
    bool? enableGiftAlerts,
    bool? enableOperationAlerts,
    bool? enableBaroAlerts,
    bool? enableDarvoAlerts,
    bool? enableSorieAlerts,
    bool? enableArchonAlerts,
    bool? enablePrimeAccess,
    bool? enableStreams,
    bool? enableUpdates,
    int? settingsId,
  }) => ToggleSetting(
    id: id ?? this.id,
    enableGiftAlerts: enableGiftAlerts ?? this.enableGiftAlerts,
    enableOperationAlerts: enableOperationAlerts ?? this.enableOperationAlerts,
    enableBaroAlerts: enableBaroAlerts ?? this.enableBaroAlerts,
    enableDarvoAlerts: enableDarvoAlerts ?? this.enableDarvoAlerts,
    enableSorieAlerts: enableSorieAlerts ?? this.enableSorieAlerts,
    enableArchonAlerts: enableArchonAlerts ?? this.enableArchonAlerts,
    enablePrimeAccess: enablePrimeAccess ?? this.enablePrimeAccess,
    enableStreams: enableStreams ?? this.enableStreams,
    enableUpdates: enableUpdates ?? this.enableUpdates,
    settingsId: settingsId ?? this.settingsId,
  );
  ToggleSetting copyWithCompanion(ToggleSettingsCompanion data) {
    return ToggleSetting(
      id: data.id.present ? data.id.value : this.id,
      enableGiftAlerts: data.enableGiftAlerts.present
          ? data.enableGiftAlerts.value
          : this.enableGiftAlerts,
      enableOperationAlerts: data.enableOperationAlerts.present
          ? data.enableOperationAlerts.value
          : this.enableOperationAlerts,
      enableBaroAlerts: data.enableBaroAlerts.present
          ? data.enableBaroAlerts.value
          : this.enableBaroAlerts,
      enableDarvoAlerts: data.enableDarvoAlerts.present
          ? data.enableDarvoAlerts.value
          : this.enableDarvoAlerts,
      enableSorieAlerts: data.enableSorieAlerts.present
          ? data.enableSorieAlerts.value
          : this.enableSorieAlerts,
      enableArchonAlerts: data.enableArchonAlerts.present
          ? data.enableArchonAlerts.value
          : this.enableArchonAlerts,
      enablePrimeAccess: data.enablePrimeAccess.present
          ? data.enablePrimeAccess.value
          : this.enablePrimeAccess,
      enableStreams: data.enableStreams.present
          ? data.enableStreams.value
          : this.enableStreams,
      enableUpdates: data.enableUpdates.present
          ? data.enableUpdates.value
          : this.enableUpdates,
      settingsId: data.settingsId.present
          ? data.settingsId.value
          : this.settingsId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ToggleSetting(')
          ..write('id: $id, ')
          ..write('enableGiftAlerts: $enableGiftAlerts, ')
          ..write('enableOperationAlerts: $enableOperationAlerts, ')
          ..write('enableBaroAlerts: $enableBaroAlerts, ')
          ..write('enableDarvoAlerts: $enableDarvoAlerts, ')
          ..write('enableSorieAlerts: $enableSorieAlerts, ')
          ..write('enableArchonAlerts: $enableArchonAlerts, ')
          ..write('enablePrimeAccess: $enablePrimeAccess, ')
          ..write('enableStreams: $enableStreams, ')
          ..write('enableUpdates: $enableUpdates, ')
          ..write('settingsId: $settingsId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    enableGiftAlerts,
    enableOperationAlerts,
    enableBaroAlerts,
    enableDarvoAlerts,
    enableSorieAlerts,
    enableArchonAlerts,
    enablePrimeAccess,
    enableStreams,
    enableUpdates,
    settingsId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ToggleSetting &&
          other.id == this.id &&
          other.enableGiftAlerts == this.enableGiftAlerts &&
          other.enableOperationAlerts == this.enableOperationAlerts &&
          other.enableBaroAlerts == this.enableBaroAlerts &&
          other.enableDarvoAlerts == this.enableDarvoAlerts &&
          other.enableSorieAlerts == this.enableSorieAlerts &&
          other.enableArchonAlerts == this.enableArchonAlerts &&
          other.enablePrimeAccess == this.enablePrimeAccess &&
          other.enableStreams == this.enableStreams &&
          other.enableUpdates == this.enableUpdates &&
          other.settingsId == this.settingsId);
}

class ToggleSettingsCompanion extends UpdateCompanion<ToggleSetting> {
  final Value<int> id;
  final Value<bool> enableGiftAlerts;
  final Value<bool> enableOperationAlerts;
  final Value<bool> enableBaroAlerts;
  final Value<bool> enableDarvoAlerts;
  final Value<bool> enableSorieAlerts;
  final Value<bool> enableArchonAlerts;
  final Value<bool> enablePrimeAccess;
  final Value<bool> enableStreams;
  final Value<bool> enableUpdates;
  final Value<int> settingsId;
  const ToggleSettingsCompanion({
    this.id = const Value.absent(),
    this.enableGiftAlerts = const Value.absent(),
    this.enableOperationAlerts = const Value.absent(),
    this.enableBaroAlerts = const Value.absent(),
    this.enableDarvoAlerts = const Value.absent(),
    this.enableSorieAlerts = const Value.absent(),
    this.enableArchonAlerts = const Value.absent(),
    this.enablePrimeAccess = const Value.absent(),
    this.enableStreams = const Value.absent(),
    this.enableUpdates = const Value.absent(),
    this.settingsId = const Value.absent(),
  });
  ToggleSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.enableGiftAlerts = const Value.absent(),
    this.enableOperationAlerts = const Value.absent(),
    this.enableBaroAlerts = const Value.absent(),
    this.enableDarvoAlerts = const Value.absent(),
    this.enableSorieAlerts = const Value.absent(),
    this.enableArchonAlerts = const Value.absent(),
    this.enablePrimeAccess = const Value.absent(),
    this.enableStreams = const Value.absent(),
    this.enableUpdates = const Value.absent(),
    required int settingsId,
  }) : settingsId = Value(settingsId);
  static Insertable<ToggleSetting> custom({
    Expression<int>? id,
    Expression<bool>? enableGiftAlerts,
    Expression<bool>? enableOperationAlerts,
    Expression<bool>? enableBaroAlerts,
    Expression<bool>? enableDarvoAlerts,
    Expression<bool>? enableSorieAlerts,
    Expression<bool>? enableArchonAlerts,
    Expression<bool>? enablePrimeAccess,
    Expression<bool>? enableStreams,
    Expression<bool>? enableUpdates,
    Expression<int>? settingsId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enableGiftAlerts != null) 'enable_gift_alerts': enableGiftAlerts,
      if (enableOperationAlerts != null)
        'enable_operation_alerts': enableOperationAlerts,
      if (enableBaroAlerts != null) 'enable_baro_alerts': enableBaroAlerts,
      if (enableDarvoAlerts != null) 'enable_darvo_alerts': enableDarvoAlerts,
      if (enableSorieAlerts != null) 'enable_sorie_alerts': enableSorieAlerts,
      if (enableArchonAlerts != null)
        'enable_archon_alerts': enableArchonAlerts,
      if (enablePrimeAccess != null) 'enable_prime_access': enablePrimeAccess,
      if (enableStreams != null) 'enable_streams': enableStreams,
      if (enableUpdates != null) 'enable_updates': enableUpdates,
      if (settingsId != null) 'settings_id': settingsId,
    });
  }

  ToggleSettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? enableGiftAlerts,
    Value<bool>? enableOperationAlerts,
    Value<bool>? enableBaroAlerts,
    Value<bool>? enableDarvoAlerts,
    Value<bool>? enableSorieAlerts,
    Value<bool>? enableArchonAlerts,
    Value<bool>? enablePrimeAccess,
    Value<bool>? enableStreams,
    Value<bool>? enableUpdates,
    Value<int>? settingsId,
  }) {
    return ToggleSettingsCompanion(
      id: id ?? this.id,
      enableGiftAlerts: enableGiftAlerts ?? this.enableGiftAlerts,
      enableOperationAlerts:
          enableOperationAlerts ?? this.enableOperationAlerts,
      enableBaroAlerts: enableBaroAlerts ?? this.enableBaroAlerts,
      enableDarvoAlerts: enableDarvoAlerts ?? this.enableDarvoAlerts,
      enableSorieAlerts: enableSorieAlerts ?? this.enableSorieAlerts,
      enableArchonAlerts: enableArchonAlerts ?? this.enableArchonAlerts,
      enablePrimeAccess: enablePrimeAccess ?? this.enablePrimeAccess,
      enableStreams: enableStreams ?? this.enableStreams,
      enableUpdates: enableUpdates ?? this.enableUpdates,
      settingsId: settingsId ?? this.settingsId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (enableGiftAlerts.present) {
      map['enable_gift_alerts'] = Variable<bool>(enableGiftAlerts.value);
    }
    if (enableOperationAlerts.present) {
      map['enable_operation_alerts'] = Variable<bool>(
        enableOperationAlerts.value,
      );
    }
    if (enableBaroAlerts.present) {
      map['enable_baro_alerts'] = Variable<bool>(enableBaroAlerts.value);
    }
    if (enableDarvoAlerts.present) {
      map['enable_darvo_alerts'] = Variable<bool>(enableDarvoAlerts.value);
    }
    if (enableSorieAlerts.present) {
      map['enable_sorie_alerts'] = Variable<bool>(enableSorieAlerts.value);
    }
    if (enableArchonAlerts.present) {
      map['enable_archon_alerts'] = Variable<bool>(enableArchonAlerts.value);
    }
    if (enablePrimeAccess.present) {
      map['enable_prime_access'] = Variable<bool>(enablePrimeAccess.value);
    }
    if (enableStreams.present) {
      map['enable_streams'] = Variable<bool>(enableStreams.value);
    }
    if (enableUpdates.present) {
      map['enable_updates'] = Variable<bool>(enableUpdates.value);
    }
    if (settingsId.present) {
      map['settings_id'] = Variable<int>(settingsId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ToggleSettingsCompanion(')
          ..write('id: $id, ')
          ..write('enableGiftAlerts: $enableGiftAlerts, ')
          ..write('enableOperationAlerts: $enableOperationAlerts, ')
          ..write('enableBaroAlerts: $enableBaroAlerts, ')
          ..write('enableDarvoAlerts: $enableDarvoAlerts, ')
          ..write('enableSorieAlerts: $enableSorieAlerts, ')
          ..write('enableArchonAlerts: $enableArchonAlerts, ')
          ..write('enablePrimeAccess: $enablePrimeAccess, ')
          ..write('enableStreams: $enableStreams, ')
          ..write('enableUpdates: $enableUpdates, ')
          ..write('settingsId: $settingsId')
          ..write(')'))
        .toString();
  }
}

class $CycleFiltersTable extends CycleFilters
    with TableInfo<$CycleFiltersTable, CycleFilter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CycleFiltersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _togglesIdMeta = const VerificationMeta(
    'togglesId',
  );
  @override
  late final GeneratedColumn<int> togglesId = GeneratedColumn<int>(
    'toggles_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES toggle_settings (id)',
    ),
  );
  static const VerificationMeta _phaseMeta = const VerificationMeta('phase');
  @override
  late final GeneratedColumn<String> phase = GeneratedColumn<String>(
    'phase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, type, togglesId, phase];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cycle_filters';
  @override
  VerificationContext validateIntegrity(
    Insertable<CycleFilter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('toggles_id')) {
      context.handle(
        _togglesIdMeta,
        togglesId.isAcceptableOrUnknown(data['toggles_id']!, _togglesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_togglesIdMeta);
    }
    if (data.containsKey('phase')) {
      context.handle(
        _phaseMeta,
        phase.isAcceptableOrUnknown(data['phase']!, _phaseMeta),
      );
    } else if (isInserting) {
      context.missing(_phaseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CycleFilter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CycleFilter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      togglesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}toggles_id'],
      )!,
      phase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phase'],
      )!,
    );
  }

  @override
  $CycleFiltersTable createAlias(String alias) {
    return $CycleFiltersTable(attachedDatabase, alias);
  }
}

class CycleFilter extends DataClass implements Insertable<CycleFilter> {
  final int id;
  final String type;
  final int togglesId;
  final String phase;
  const CycleFilter({
    required this.id,
    required this.type,
    required this.togglesId,
    required this.phase,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['toggles_id'] = Variable<int>(togglesId);
    map['phase'] = Variable<String>(phase);
    return map;
  }

  CycleFiltersCompanion toCompanion(bool nullToAbsent) {
    return CycleFiltersCompanion(
      id: Value(id),
      type: Value(type),
      togglesId: Value(togglesId),
      phase: Value(phase),
    );
  }

  factory CycleFilter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CycleFilter(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      togglesId: serializer.fromJson<int>(json['togglesId']),
      phase: serializer.fromJson<String>(json['phase']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'togglesId': serializer.toJson<int>(togglesId),
      'phase': serializer.toJson<String>(phase),
    };
  }

  CycleFilter copyWith({
    int? id,
    String? type,
    int? togglesId,
    String? phase,
  }) => CycleFilter(
    id: id ?? this.id,
    type: type ?? this.type,
    togglesId: togglesId ?? this.togglesId,
    phase: phase ?? this.phase,
  );
  CycleFilter copyWithCompanion(CycleFiltersCompanion data) {
    return CycleFilter(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      togglesId: data.togglesId.present ? data.togglesId.value : this.togglesId,
      phase: data.phase.present ? data.phase.value : this.phase,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CycleFilter(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('togglesId: $togglesId, ')
          ..write('phase: $phase')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, togglesId, phase);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CycleFilter &&
          other.id == this.id &&
          other.type == this.type &&
          other.togglesId == this.togglesId &&
          other.phase == this.phase);
}

class CycleFiltersCompanion extends UpdateCompanion<CycleFilter> {
  final Value<int> id;
  final Value<String> type;
  final Value<int> togglesId;
  final Value<String> phase;
  const CycleFiltersCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.togglesId = const Value.absent(),
    this.phase = const Value.absent(),
  });
  CycleFiltersCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required int togglesId,
    required String phase,
  }) : type = Value(type),
       togglesId = Value(togglesId),
       phase = Value(phase);
  static Insertable<CycleFilter> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<int>? togglesId,
    Expression<String>? phase,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (togglesId != null) 'toggles_id': togglesId,
      if (phase != null) 'phase': phase,
    });
  }

  CycleFiltersCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<int>? togglesId,
    Value<String>? phase,
  }) {
    return CycleFiltersCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      togglesId: togglesId ?? this.togglesId,
      phase: phase ?? this.phase,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (togglesId.present) {
      map['toggles_id'] = Variable<int>(togglesId.value);
    }
    if (phase.present) {
      map['phase'] = Variable<String>(phase.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CycleFiltersCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('togglesId: $togglesId, ')
          ..write('phase: $phase')
          ..write(')'))
        .toString();
  }
}

class $FissureFiltersTable extends FissureFilters
    with TableInfo<$FissureFiltersTable, FissureFilter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FissureFiltersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _togglesIdMeta = const VerificationMeta(
    'togglesId',
  );
  @override
  late final GeneratedColumn<int> togglesId = GeneratedColumn<int>(
    'toggles_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES toggle_settings (id)',
    ),
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<int> tier = GeneratedColumn<int>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enableRegularMeta = const VerificationMeta(
    'enableRegular',
  );
  @override
  late final GeneratedColumn<bool> enableRegular = GeneratedColumn<bool>(
    'enable_regular',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_regular" IN (0, 1))',
    ),
  );
  static const VerificationMeta _enableSteelPathMeta = const VerificationMeta(
    'enableSteelPath',
  );
  @override
  late final GeneratedColumn<bool> enableSteelPath = GeneratedColumn<bool>(
    'enable_steel_path',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_steel_path" IN (0, 1))',
    ),
  );
  static const VerificationMeta _enableVoidStormMeta = const VerificationMeta(
    'enableVoidStorm',
  );
  @override
  late final GeneratedColumn<bool> enableVoidStorm = GeneratedColumn<bool>(
    'enable_void_storm',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_void_storm" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    togglesId,
    tier,
    enableRegular,
    enableSteelPath,
    enableVoidStorm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fissure_filters';
  @override
  VerificationContext validateIntegrity(
    Insertable<FissureFilter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('toggles_id')) {
      context.handle(
        _togglesIdMeta,
        togglesId.isAcceptableOrUnknown(data['toggles_id']!, _togglesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_togglesIdMeta);
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    } else if (isInserting) {
      context.missing(_tierMeta);
    }
    if (data.containsKey('enable_regular')) {
      context.handle(
        _enableRegularMeta,
        enableRegular.isAcceptableOrUnknown(
          data['enable_regular']!,
          _enableRegularMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_enableRegularMeta);
    }
    if (data.containsKey('enable_steel_path')) {
      context.handle(
        _enableSteelPathMeta,
        enableSteelPath.isAcceptableOrUnknown(
          data['enable_steel_path']!,
          _enableSteelPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_enableSteelPathMeta);
    }
    if (data.containsKey('enable_void_storm')) {
      context.handle(
        _enableVoidStormMeta,
        enableVoidStorm.isAcceptableOrUnknown(
          data['enable_void_storm']!,
          _enableVoidStormMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_enableVoidStormMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FissureFilter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FissureFilter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      togglesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}toggles_id'],
      )!,
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tier'],
      )!,
      enableRegular: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_regular'],
      )!,
      enableSteelPath: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_steel_path'],
      )!,
      enableVoidStorm: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_void_storm'],
      )!,
    );
  }

  @override
  $FissureFiltersTable createAlias(String alias) {
    return $FissureFiltersTable(attachedDatabase, alias);
  }
}

class FissureFilter extends DataClass implements Insertable<FissureFilter> {
  final int id;
  final String type;
  final int togglesId;
  final int tier;
  final bool enableRegular;
  final bool enableSteelPath;
  final bool enableVoidStorm;
  const FissureFilter({
    required this.id,
    required this.type,
    required this.togglesId,
    required this.tier,
    required this.enableRegular,
    required this.enableSteelPath,
    required this.enableVoidStorm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['toggles_id'] = Variable<int>(togglesId);
    map['tier'] = Variable<int>(tier);
    map['enable_regular'] = Variable<bool>(enableRegular);
    map['enable_steel_path'] = Variable<bool>(enableSteelPath);
    map['enable_void_storm'] = Variable<bool>(enableVoidStorm);
    return map;
  }

  FissureFiltersCompanion toCompanion(bool nullToAbsent) {
    return FissureFiltersCompanion(
      id: Value(id),
      type: Value(type),
      togglesId: Value(togglesId),
      tier: Value(tier),
      enableRegular: Value(enableRegular),
      enableSteelPath: Value(enableSteelPath),
      enableVoidStorm: Value(enableVoidStorm),
    );
  }

  factory FissureFilter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FissureFilter(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      togglesId: serializer.fromJson<int>(json['togglesId']),
      tier: serializer.fromJson<int>(json['tier']),
      enableRegular: serializer.fromJson<bool>(json['enableRegular']),
      enableSteelPath: serializer.fromJson<bool>(json['enableSteelPath']),
      enableVoidStorm: serializer.fromJson<bool>(json['enableVoidStorm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'togglesId': serializer.toJson<int>(togglesId),
      'tier': serializer.toJson<int>(tier),
      'enableRegular': serializer.toJson<bool>(enableRegular),
      'enableSteelPath': serializer.toJson<bool>(enableSteelPath),
      'enableVoidStorm': serializer.toJson<bool>(enableVoidStorm),
    };
  }

  FissureFilter copyWith({
    int? id,
    String? type,
    int? togglesId,
    int? tier,
    bool? enableRegular,
    bool? enableSteelPath,
    bool? enableVoidStorm,
  }) => FissureFilter(
    id: id ?? this.id,
    type: type ?? this.type,
    togglesId: togglesId ?? this.togglesId,
    tier: tier ?? this.tier,
    enableRegular: enableRegular ?? this.enableRegular,
    enableSteelPath: enableSteelPath ?? this.enableSteelPath,
    enableVoidStorm: enableVoidStorm ?? this.enableVoidStorm,
  );
  FissureFilter copyWithCompanion(FissureFiltersCompanion data) {
    return FissureFilter(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      togglesId: data.togglesId.present ? data.togglesId.value : this.togglesId,
      tier: data.tier.present ? data.tier.value : this.tier,
      enableRegular: data.enableRegular.present
          ? data.enableRegular.value
          : this.enableRegular,
      enableSteelPath: data.enableSteelPath.present
          ? data.enableSteelPath.value
          : this.enableSteelPath,
      enableVoidStorm: data.enableVoidStorm.present
          ? data.enableVoidStorm.value
          : this.enableVoidStorm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FissureFilter(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('togglesId: $togglesId, ')
          ..write('tier: $tier, ')
          ..write('enableRegular: $enableRegular, ')
          ..write('enableSteelPath: $enableSteelPath, ')
          ..write('enableVoidStorm: $enableVoidStorm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    togglesId,
    tier,
    enableRegular,
    enableSteelPath,
    enableVoidStorm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FissureFilter &&
          other.id == this.id &&
          other.type == this.type &&
          other.togglesId == this.togglesId &&
          other.tier == this.tier &&
          other.enableRegular == this.enableRegular &&
          other.enableSteelPath == this.enableSteelPath &&
          other.enableVoidStorm == this.enableVoidStorm);
}

class FissureFiltersCompanion extends UpdateCompanion<FissureFilter> {
  final Value<int> id;
  final Value<String> type;
  final Value<int> togglesId;
  final Value<int> tier;
  final Value<bool> enableRegular;
  final Value<bool> enableSteelPath;
  final Value<bool> enableVoidStorm;
  const FissureFiltersCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.togglesId = const Value.absent(),
    this.tier = const Value.absent(),
    this.enableRegular = const Value.absent(),
    this.enableSteelPath = const Value.absent(),
    this.enableVoidStorm = const Value.absent(),
  });
  FissureFiltersCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required int togglesId,
    required int tier,
    required bool enableRegular,
    required bool enableSteelPath,
    required bool enableVoidStorm,
  }) : type = Value(type),
       togglesId = Value(togglesId),
       tier = Value(tier),
       enableRegular = Value(enableRegular),
       enableSteelPath = Value(enableSteelPath),
       enableVoidStorm = Value(enableVoidStorm);
  static Insertable<FissureFilter> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<int>? togglesId,
    Expression<int>? tier,
    Expression<bool>? enableRegular,
    Expression<bool>? enableSteelPath,
    Expression<bool>? enableVoidStorm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (togglesId != null) 'toggles_id': togglesId,
      if (tier != null) 'tier': tier,
      if (enableRegular != null) 'enable_regular': enableRegular,
      if (enableSteelPath != null) 'enable_steel_path': enableSteelPath,
      if (enableVoidStorm != null) 'enable_void_storm': enableVoidStorm,
    });
  }

  FissureFiltersCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<int>? togglesId,
    Value<int>? tier,
    Value<bool>? enableRegular,
    Value<bool>? enableSteelPath,
    Value<bool>? enableVoidStorm,
  }) {
    return FissureFiltersCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      togglesId: togglesId ?? this.togglesId,
      tier: tier ?? this.tier,
      enableRegular: enableRegular ?? this.enableRegular,
      enableSteelPath: enableSteelPath ?? this.enableSteelPath,
      enableVoidStorm: enableVoidStorm ?? this.enableVoidStorm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (togglesId.present) {
      map['toggles_id'] = Variable<int>(togglesId.value);
    }
    if (tier.present) {
      map['tier'] = Variable<int>(tier.value);
    }
    if (enableRegular.present) {
      map['enable_regular'] = Variable<bool>(enableRegular.value);
    }
    if (enableSteelPath.present) {
      map['enable_steel_path'] = Variable<bool>(enableSteelPath.value);
    }
    if (enableVoidStorm.present) {
      map['enable_void_storm'] = Variable<bool>(enableVoidStorm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FissureFiltersCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('togglesId: $togglesId, ')
          ..write('tier: $tier, ')
          ..write('enableRegular: $enableRegular, ')
          ..write('enableSteelPath: $enableSteelPath, ')
          ..write('enableVoidStorm: $enableVoidStorm')
          ..write(')'))
        .toString();
  }
}

abstract class _$SettingsDatabase extends GeneratedDatabase {
  _$SettingsDatabase(QueryExecutor e) : super(e);
  $SettingsDatabaseManager get managers => $SettingsDatabaseManager(this);
  late final $AppConfigsTable appConfigs = $AppConfigsTable(this);
  late final $ToggleSettingsTable toggleSettings = $ToggleSettingsTable(this);
  late final $CycleFiltersTable cycleFilters = $CycleFiltersTable(this);
  late final $FissureFiltersTable fissureFilters = $FissureFiltersTable(this);
  late final CycleFiltersAccessor cycleFiltersAccessor = CycleFiltersAccessor(
    this as SettingsDatabase,
  );
  late final FissureFilterAccessor fissureFilterAccessor =
      FissureFilterAccessor(this as SettingsDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appConfigs,
    toggleSettings,
    cycleFilters,
    fissureFilters,
  ];
}

typedef $$AppConfigsTableCreateCompanionBuilder =
    AppConfigsCompanion Function({
      Value<int> id,
      Value<String> language,
      Value<int> theme,
      Value<bool> optOut,
      Value<String?> account,
    });
typedef $$AppConfigsTableUpdateCompanionBuilder =
    AppConfigsCompanion Function({
      Value<int> id,
      Value<String> language,
      Value<int> theme,
      Value<bool> optOut,
      Value<String?> account,
    });

final class $$AppConfigsTableReferences
    extends BaseReferences<_$SettingsDatabase, $AppConfigsTable, AppConfig> {
  $$AppConfigsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ToggleSettingsTable, List<ToggleSetting>>
  _toggleSettingsRefsTable(_$SettingsDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.toggleSettings,
        aliasName: $_aliasNameGenerator(
          db.appConfigs.id,
          db.toggleSettings.settingsId,
        ),
      );

  $$ToggleSettingsTableProcessedTableManager get toggleSettingsRefs {
    final manager = $$ToggleSettingsTableTableManager(
      $_db,
      $_db.toggleSettings,
    ).filter((f) => f.settingsId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_toggleSettingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AppConfigsTableFilterComposer
    extends Composer<_$SettingsDatabase, $AppConfigsTable> {
  $$AppConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get optOut => $composableBuilder(
    column: $table.optOut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get account => $composableBuilder(
    column: $table.account,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> toggleSettingsRefs(
    Expression<bool> Function($$ToggleSettingsTableFilterComposer f) f,
  ) {
    final $$ToggleSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.toggleSettings,
      getReferencedColumn: (t) => t.settingsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToggleSettingsTableFilterComposer(
            $db: $db,
            $table: $db.toggleSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AppConfigsTableOrderingComposer
    extends Composer<_$SettingsDatabase, $AppConfigsTable> {
  $$AppConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get optOut => $composableBuilder(
    column: $table.optOut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get account => $composableBuilder(
    column: $table.account,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppConfigsTableAnnotationComposer
    extends Composer<_$SettingsDatabase, $AppConfigsTable> {
  $$AppConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<int> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumn<bool> get optOut =>
      $composableBuilder(column: $table.optOut, builder: (column) => column);

  GeneratedColumn<String> get account =>
      $composableBuilder(column: $table.account, builder: (column) => column);

  Expression<T> toggleSettingsRefs<T extends Object>(
    Expression<T> Function($$ToggleSettingsTableAnnotationComposer a) f,
  ) {
    final $$ToggleSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.toggleSettings,
      getReferencedColumn: (t) => t.settingsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToggleSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.toggleSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AppConfigsTableTableManager
    extends
        RootTableManager<
          _$SettingsDatabase,
          $AppConfigsTable,
          AppConfig,
          $$AppConfigsTableFilterComposer,
          $$AppConfigsTableOrderingComposer,
          $$AppConfigsTableAnnotationComposer,
          $$AppConfigsTableCreateCompanionBuilder,
          $$AppConfigsTableUpdateCompanionBuilder,
          (AppConfig, $$AppConfigsTableReferences),
          AppConfig,
          PrefetchHooks Function({bool toggleSettingsRefs})
        > {
  $$AppConfigsTableTableManager(_$SettingsDatabase db, $AppConfigsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<int> theme = const Value.absent(),
                Value<bool> optOut = const Value.absent(),
                Value<String?> account = const Value.absent(),
              }) => AppConfigsCompanion(
                id: id,
                language: language,
                theme: theme,
                optOut: optOut,
                account: account,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<int> theme = const Value.absent(),
                Value<bool> optOut = const Value.absent(),
                Value<String?> account = const Value.absent(),
              }) => AppConfigsCompanion.insert(
                id: id,
                language: language,
                theme: theme,
                optOut: optOut,
                account: account,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AppConfigsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({toggleSettingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (toggleSettingsRefs) db.toggleSettings,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (toggleSettingsRefs)
                    await $_getPrefetchedData<
                      AppConfig,
                      $AppConfigsTable,
                      ToggleSetting
                    >(
                      currentTable: table,
                      referencedTable: $$AppConfigsTableReferences
                          ._toggleSettingsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AppConfigsTableReferences(
                            db,
                            table,
                            p0,
                          ).toggleSettingsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.settingsId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AppConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$SettingsDatabase,
      $AppConfigsTable,
      AppConfig,
      $$AppConfigsTableFilterComposer,
      $$AppConfigsTableOrderingComposer,
      $$AppConfigsTableAnnotationComposer,
      $$AppConfigsTableCreateCompanionBuilder,
      $$AppConfigsTableUpdateCompanionBuilder,
      (AppConfig, $$AppConfigsTableReferences),
      AppConfig,
      PrefetchHooks Function({bool toggleSettingsRefs})
    >;
typedef $$ToggleSettingsTableCreateCompanionBuilder =
    ToggleSettingsCompanion Function({
      Value<int> id,
      Value<bool> enableGiftAlerts,
      Value<bool> enableOperationAlerts,
      Value<bool> enableBaroAlerts,
      Value<bool> enableDarvoAlerts,
      Value<bool> enableSorieAlerts,
      Value<bool> enableArchonAlerts,
      Value<bool> enablePrimeAccess,
      Value<bool> enableStreams,
      Value<bool> enableUpdates,
      required int settingsId,
    });
typedef $$ToggleSettingsTableUpdateCompanionBuilder =
    ToggleSettingsCompanion Function({
      Value<int> id,
      Value<bool> enableGiftAlerts,
      Value<bool> enableOperationAlerts,
      Value<bool> enableBaroAlerts,
      Value<bool> enableDarvoAlerts,
      Value<bool> enableSorieAlerts,
      Value<bool> enableArchonAlerts,
      Value<bool> enablePrimeAccess,
      Value<bool> enableStreams,
      Value<bool> enableUpdates,
      Value<int> settingsId,
    });

final class $$ToggleSettingsTableReferences
    extends
        BaseReferences<
          _$SettingsDatabase,
          $ToggleSettingsTable,
          ToggleSetting
        > {
  $$ToggleSettingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AppConfigsTable _settingsIdTable(_$SettingsDatabase db) =>
      db.appConfigs.createAlias(
        $_aliasNameGenerator(db.toggleSettings.settingsId, db.appConfigs.id),
      );

  $$AppConfigsTableProcessedTableManager get settingsId {
    final $_column = $_itemColumn<int>('settings_id')!;

    final manager = $$AppConfigsTableTableManager(
      $_db,
      $_db.appConfigs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_settingsIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CycleFiltersTable, List<CycleFilter>>
  _cycleFiltersRefsTable(_$SettingsDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cycleFilters,
        aliasName: $_aliasNameGenerator(
          db.toggleSettings.id,
          db.cycleFilters.togglesId,
        ),
      );

  $$CycleFiltersTableProcessedTableManager get cycleFiltersRefs {
    final manager = $$CycleFiltersTableTableManager(
      $_db,
      $_db.cycleFilters,
    ).filter((f) => f.togglesId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cycleFiltersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FissureFiltersTable, List<FissureFilter>>
  _fissureFiltersRefsTable(_$SettingsDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.fissureFilters,
        aliasName: $_aliasNameGenerator(
          db.toggleSettings.id,
          db.fissureFilters.togglesId,
        ),
      );

  $$FissureFiltersTableProcessedTableManager get fissureFiltersRefs {
    final manager = $$FissureFiltersTableTableManager(
      $_db,
      $_db.fissureFilters,
    ).filter((f) => f.togglesId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fissureFiltersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ToggleSettingsTableFilterComposer
    extends Composer<_$SettingsDatabase, $ToggleSettingsTable> {
  $$ToggleSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableGiftAlerts => $composableBuilder(
    column: $table.enableGiftAlerts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableOperationAlerts => $composableBuilder(
    column: $table.enableOperationAlerts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableBaroAlerts => $composableBuilder(
    column: $table.enableBaroAlerts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableDarvoAlerts => $composableBuilder(
    column: $table.enableDarvoAlerts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableSorieAlerts => $composableBuilder(
    column: $table.enableSorieAlerts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableArchonAlerts => $composableBuilder(
    column: $table.enableArchonAlerts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enablePrimeAccess => $composableBuilder(
    column: $table.enablePrimeAccess,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableStreams => $composableBuilder(
    column: $table.enableStreams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableUpdates => $composableBuilder(
    column: $table.enableUpdates,
    builder: (column) => ColumnFilters(column),
  );

  $$AppConfigsTableFilterComposer get settingsId {
    final $$AppConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.settingsId,
      referencedTable: $db.appConfigs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppConfigsTableFilterComposer(
            $db: $db,
            $table: $db.appConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> cycleFiltersRefs(
    Expression<bool> Function($$CycleFiltersTableFilterComposer f) f,
  ) {
    final $$CycleFiltersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cycleFilters,
      getReferencedColumn: (t) => t.togglesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CycleFiltersTableFilterComposer(
            $db: $db,
            $table: $db.cycleFilters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fissureFiltersRefs(
    Expression<bool> Function($$FissureFiltersTableFilterComposer f) f,
  ) {
    final $$FissureFiltersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fissureFilters,
      getReferencedColumn: (t) => t.togglesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FissureFiltersTableFilterComposer(
            $db: $db,
            $table: $db.fissureFilters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ToggleSettingsTableOrderingComposer
    extends Composer<_$SettingsDatabase, $ToggleSettingsTable> {
  $$ToggleSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableGiftAlerts => $composableBuilder(
    column: $table.enableGiftAlerts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableOperationAlerts => $composableBuilder(
    column: $table.enableOperationAlerts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableBaroAlerts => $composableBuilder(
    column: $table.enableBaroAlerts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableDarvoAlerts => $composableBuilder(
    column: $table.enableDarvoAlerts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableSorieAlerts => $composableBuilder(
    column: $table.enableSorieAlerts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableArchonAlerts => $composableBuilder(
    column: $table.enableArchonAlerts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enablePrimeAccess => $composableBuilder(
    column: $table.enablePrimeAccess,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableStreams => $composableBuilder(
    column: $table.enableStreams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableUpdates => $composableBuilder(
    column: $table.enableUpdates,
    builder: (column) => ColumnOrderings(column),
  );

  $$AppConfigsTableOrderingComposer get settingsId {
    final $$AppConfigsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.settingsId,
      referencedTable: $db.appConfigs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppConfigsTableOrderingComposer(
            $db: $db,
            $table: $db.appConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ToggleSettingsTableAnnotationComposer
    extends Composer<_$SettingsDatabase, $ToggleSettingsTable> {
  $$ToggleSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get enableGiftAlerts => $composableBuilder(
    column: $table.enableGiftAlerts,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableOperationAlerts => $composableBuilder(
    column: $table.enableOperationAlerts,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableBaroAlerts => $composableBuilder(
    column: $table.enableBaroAlerts,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableDarvoAlerts => $composableBuilder(
    column: $table.enableDarvoAlerts,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableSorieAlerts => $composableBuilder(
    column: $table.enableSorieAlerts,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableArchonAlerts => $composableBuilder(
    column: $table.enableArchonAlerts,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enablePrimeAccess => $composableBuilder(
    column: $table.enablePrimeAccess,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableStreams => $composableBuilder(
    column: $table.enableStreams,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableUpdates => $composableBuilder(
    column: $table.enableUpdates,
    builder: (column) => column,
  );

  $$AppConfigsTableAnnotationComposer get settingsId {
    final $$AppConfigsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.settingsId,
      referencedTable: $db.appConfigs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppConfigsTableAnnotationComposer(
            $db: $db,
            $table: $db.appConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> cycleFiltersRefs<T extends Object>(
    Expression<T> Function($$CycleFiltersTableAnnotationComposer a) f,
  ) {
    final $$CycleFiltersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cycleFilters,
      getReferencedColumn: (t) => t.togglesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CycleFiltersTableAnnotationComposer(
            $db: $db,
            $table: $db.cycleFilters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fissureFiltersRefs<T extends Object>(
    Expression<T> Function($$FissureFiltersTableAnnotationComposer a) f,
  ) {
    final $$FissureFiltersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fissureFilters,
      getReferencedColumn: (t) => t.togglesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FissureFiltersTableAnnotationComposer(
            $db: $db,
            $table: $db.fissureFilters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ToggleSettingsTableTableManager
    extends
        RootTableManager<
          _$SettingsDatabase,
          $ToggleSettingsTable,
          ToggleSetting,
          $$ToggleSettingsTableFilterComposer,
          $$ToggleSettingsTableOrderingComposer,
          $$ToggleSettingsTableAnnotationComposer,
          $$ToggleSettingsTableCreateCompanionBuilder,
          $$ToggleSettingsTableUpdateCompanionBuilder,
          (ToggleSetting, $$ToggleSettingsTableReferences),
          ToggleSetting,
          PrefetchHooks Function({
            bool settingsId,
            bool cycleFiltersRefs,
            bool fissureFiltersRefs,
          })
        > {
  $$ToggleSettingsTableTableManager(
    _$SettingsDatabase db,
    $ToggleSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ToggleSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ToggleSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ToggleSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enableGiftAlerts = const Value.absent(),
                Value<bool> enableOperationAlerts = const Value.absent(),
                Value<bool> enableBaroAlerts = const Value.absent(),
                Value<bool> enableDarvoAlerts = const Value.absent(),
                Value<bool> enableSorieAlerts = const Value.absent(),
                Value<bool> enableArchonAlerts = const Value.absent(),
                Value<bool> enablePrimeAccess = const Value.absent(),
                Value<bool> enableStreams = const Value.absent(),
                Value<bool> enableUpdates = const Value.absent(),
                Value<int> settingsId = const Value.absent(),
              }) => ToggleSettingsCompanion(
                id: id,
                enableGiftAlerts: enableGiftAlerts,
                enableOperationAlerts: enableOperationAlerts,
                enableBaroAlerts: enableBaroAlerts,
                enableDarvoAlerts: enableDarvoAlerts,
                enableSorieAlerts: enableSorieAlerts,
                enableArchonAlerts: enableArchonAlerts,
                enablePrimeAccess: enablePrimeAccess,
                enableStreams: enableStreams,
                enableUpdates: enableUpdates,
                settingsId: settingsId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enableGiftAlerts = const Value.absent(),
                Value<bool> enableOperationAlerts = const Value.absent(),
                Value<bool> enableBaroAlerts = const Value.absent(),
                Value<bool> enableDarvoAlerts = const Value.absent(),
                Value<bool> enableSorieAlerts = const Value.absent(),
                Value<bool> enableArchonAlerts = const Value.absent(),
                Value<bool> enablePrimeAccess = const Value.absent(),
                Value<bool> enableStreams = const Value.absent(),
                Value<bool> enableUpdates = const Value.absent(),
                required int settingsId,
              }) => ToggleSettingsCompanion.insert(
                id: id,
                enableGiftAlerts: enableGiftAlerts,
                enableOperationAlerts: enableOperationAlerts,
                enableBaroAlerts: enableBaroAlerts,
                enableDarvoAlerts: enableDarvoAlerts,
                enableSorieAlerts: enableSorieAlerts,
                enableArchonAlerts: enableArchonAlerts,
                enablePrimeAccess: enablePrimeAccess,
                enableStreams: enableStreams,
                enableUpdates: enableUpdates,
                settingsId: settingsId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ToggleSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                settingsId = false,
                cycleFiltersRefs = false,
                fissureFiltersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (cycleFiltersRefs) db.cycleFilters,
                    if (fissureFiltersRefs) db.fissureFilters,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (settingsId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.settingsId,
                                    referencedTable:
                                        $$ToggleSettingsTableReferences
                                            ._settingsIdTable(db),
                                    referencedColumn:
                                        $$ToggleSettingsTableReferences
                                            ._settingsIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (cycleFiltersRefs)
                        await $_getPrefetchedData<
                          ToggleSetting,
                          $ToggleSettingsTable,
                          CycleFilter
                        >(
                          currentTable: table,
                          referencedTable: $$ToggleSettingsTableReferences
                              ._cycleFiltersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ToggleSettingsTableReferences(
                                db,
                                table,
                                p0,
                              ).cycleFiltersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.togglesId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fissureFiltersRefs)
                        await $_getPrefetchedData<
                          ToggleSetting,
                          $ToggleSettingsTable,
                          FissureFilter
                        >(
                          currentTable: table,
                          referencedTable: $$ToggleSettingsTableReferences
                              ._fissureFiltersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ToggleSettingsTableReferences(
                                db,
                                table,
                                p0,
                              ).fissureFiltersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.togglesId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ToggleSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$SettingsDatabase,
      $ToggleSettingsTable,
      ToggleSetting,
      $$ToggleSettingsTableFilterComposer,
      $$ToggleSettingsTableOrderingComposer,
      $$ToggleSettingsTableAnnotationComposer,
      $$ToggleSettingsTableCreateCompanionBuilder,
      $$ToggleSettingsTableUpdateCompanionBuilder,
      (ToggleSetting, $$ToggleSettingsTableReferences),
      ToggleSetting,
      PrefetchHooks Function({
        bool settingsId,
        bool cycleFiltersRefs,
        bool fissureFiltersRefs,
      })
    >;
typedef $$CycleFiltersTableCreateCompanionBuilder =
    CycleFiltersCompanion Function({
      Value<int> id,
      required String type,
      required int togglesId,
      required String phase,
    });
typedef $$CycleFiltersTableUpdateCompanionBuilder =
    CycleFiltersCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<int> togglesId,
      Value<String> phase,
    });

final class $$CycleFiltersTableReferences
    extends
        BaseReferences<_$SettingsDatabase, $CycleFiltersTable, CycleFilter> {
  $$CycleFiltersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ToggleSettingsTable _togglesIdTable(_$SettingsDatabase db) =>
      db.toggleSettings.createAlias(
        $_aliasNameGenerator(db.cycleFilters.togglesId, db.toggleSettings.id),
      );

  $$ToggleSettingsTableProcessedTableManager get togglesId {
    final $_column = $_itemColumn<int>('toggles_id')!;

    final manager = $$ToggleSettingsTableTableManager(
      $_db,
      $_db.toggleSettings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_togglesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CycleFiltersTableFilterComposer
    extends Composer<_$SettingsDatabase, $CycleFiltersTable> {
  $$CycleFiltersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnFilters(column),
  );

  $$ToggleSettingsTableFilterComposer get togglesId {
    final $$ToggleSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.togglesId,
      referencedTable: $db.toggleSettings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToggleSettingsTableFilterComposer(
            $db: $db,
            $table: $db.toggleSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CycleFiltersTableOrderingComposer
    extends Composer<_$SettingsDatabase, $CycleFiltersTable> {
  $$CycleFiltersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnOrderings(column),
  );

  $$ToggleSettingsTableOrderingComposer get togglesId {
    final $$ToggleSettingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.togglesId,
      referencedTable: $db.toggleSettings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToggleSettingsTableOrderingComposer(
            $db: $db,
            $table: $db.toggleSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CycleFiltersTableAnnotationComposer
    extends Composer<_$SettingsDatabase, $CycleFiltersTable> {
  $$CycleFiltersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get phase =>
      $composableBuilder(column: $table.phase, builder: (column) => column);

  $$ToggleSettingsTableAnnotationComposer get togglesId {
    final $$ToggleSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.togglesId,
      referencedTable: $db.toggleSettings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToggleSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.toggleSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CycleFiltersTableTableManager
    extends
        RootTableManager<
          _$SettingsDatabase,
          $CycleFiltersTable,
          CycleFilter,
          $$CycleFiltersTableFilterComposer,
          $$CycleFiltersTableOrderingComposer,
          $$CycleFiltersTableAnnotationComposer,
          $$CycleFiltersTableCreateCompanionBuilder,
          $$CycleFiltersTableUpdateCompanionBuilder,
          (CycleFilter, $$CycleFiltersTableReferences),
          CycleFilter,
          PrefetchHooks Function({bool togglesId})
        > {
  $$CycleFiltersTableTableManager(
    _$SettingsDatabase db,
    $CycleFiltersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CycleFiltersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CycleFiltersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CycleFiltersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> togglesId = const Value.absent(),
                Value<String> phase = const Value.absent(),
              }) => CycleFiltersCompanion(
                id: id,
                type: type,
                togglesId: togglesId,
                phase: phase,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required int togglesId,
                required String phase,
              }) => CycleFiltersCompanion.insert(
                id: id,
                type: type,
                togglesId: togglesId,
                phase: phase,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CycleFiltersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({togglesId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (togglesId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.togglesId,
                                referencedTable: $$CycleFiltersTableReferences
                                    ._togglesIdTable(db),
                                referencedColumn: $$CycleFiltersTableReferences
                                    ._togglesIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CycleFiltersTableProcessedTableManager =
    ProcessedTableManager<
      _$SettingsDatabase,
      $CycleFiltersTable,
      CycleFilter,
      $$CycleFiltersTableFilterComposer,
      $$CycleFiltersTableOrderingComposer,
      $$CycleFiltersTableAnnotationComposer,
      $$CycleFiltersTableCreateCompanionBuilder,
      $$CycleFiltersTableUpdateCompanionBuilder,
      (CycleFilter, $$CycleFiltersTableReferences),
      CycleFilter,
      PrefetchHooks Function({bool togglesId})
    >;
typedef $$FissureFiltersTableCreateCompanionBuilder =
    FissureFiltersCompanion Function({
      Value<int> id,
      required String type,
      required int togglesId,
      required int tier,
      required bool enableRegular,
      required bool enableSteelPath,
      required bool enableVoidStorm,
    });
typedef $$FissureFiltersTableUpdateCompanionBuilder =
    FissureFiltersCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<int> togglesId,
      Value<int> tier,
      Value<bool> enableRegular,
      Value<bool> enableSteelPath,
      Value<bool> enableVoidStorm,
    });

final class $$FissureFiltersTableReferences
    extends
        BaseReferences<
          _$SettingsDatabase,
          $FissureFiltersTable,
          FissureFilter
        > {
  $$FissureFiltersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ToggleSettingsTable _togglesIdTable(_$SettingsDatabase db) =>
      db.toggleSettings.createAlias(
        $_aliasNameGenerator(db.fissureFilters.togglesId, db.toggleSettings.id),
      );

  $$ToggleSettingsTableProcessedTableManager get togglesId {
    final $_column = $_itemColumn<int>('toggles_id')!;

    final manager = $$ToggleSettingsTableTableManager(
      $_db,
      $_db.toggleSettings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_togglesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FissureFiltersTableFilterComposer
    extends Composer<_$SettingsDatabase, $FissureFiltersTable> {
  $$FissureFiltersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableRegular => $composableBuilder(
    column: $table.enableRegular,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableSteelPath => $composableBuilder(
    column: $table.enableSteelPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableVoidStorm => $composableBuilder(
    column: $table.enableVoidStorm,
    builder: (column) => ColumnFilters(column),
  );

  $$ToggleSettingsTableFilterComposer get togglesId {
    final $$ToggleSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.togglesId,
      referencedTable: $db.toggleSettings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToggleSettingsTableFilterComposer(
            $db: $db,
            $table: $db.toggleSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FissureFiltersTableOrderingComposer
    extends Composer<_$SettingsDatabase, $FissureFiltersTable> {
  $$FissureFiltersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableRegular => $composableBuilder(
    column: $table.enableRegular,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableSteelPath => $composableBuilder(
    column: $table.enableSteelPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableVoidStorm => $composableBuilder(
    column: $table.enableVoidStorm,
    builder: (column) => ColumnOrderings(column),
  );

  $$ToggleSettingsTableOrderingComposer get togglesId {
    final $$ToggleSettingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.togglesId,
      referencedTable: $db.toggleSettings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToggleSettingsTableOrderingComposer(
            $db: $db,
            $table: $db.toggleSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FissureFiltersTableAnnotationComposer
    extends Composer<_$SettingsDatabase, $FissureFiltersTable> {
  $$FissureFiltersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<bool> get enableRegular => $composableBuilder(
    column: $table.enableRegular,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableSteelPath => $composableBuilder(
    column: $table.enableSteelPath,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableVoidStorm => $composableBuilder(
    column: $table.enableVoidStorm,
    builder: (column) => column,
  );

  $$ToggleSettingsTableAnnotationComposer get togglesId {
    final $$ToggleSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.togglesId,
      referencedTable: $db.toggleSettings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToggleSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.toggleSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FissureFiltersTableTableManager
    extends
        RootTableManager<
          _$SettingsDatabase,
          $FissureFiltersTable,
          FissureFilter,
          $$FissureFiltersTableFilterComposer,
          $$FissureFiltersTableOrderingComposer,
          $$FissureFiltersTableAnnotationComposer,
          $$FissureFiltersTableCreateCompanionBuilder,
          $$FissureFiltersTableUpdateCompanionBuilder,
          (FissureFilter, $$FissureFiltersTableReferences),
          FissureFilter,
          PrefetchHooks Function({bool togglesId})
        > {
  $$FissureFiltersTableTableManager(
    _$SettingsDatabase db,
    $FissureFiltersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FissureFiltersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FissureFiltersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FissureFiltersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> togglesId = const Value.absent(),
                Value<int> tier = const Value.absent(),
                Value<bool> enableRegular = const Value.absent(),
                Value<bool> enableSteelPath = const Value.absent(),
                Value<bool> enableVoidStorm = const Value.absent(),
              }) => FissureFiltersCompanion(
                id: id,
                type: type,
                togglesId: togglesId,
                tier: tier,
                enableRegular: enableRegular,
                enableSteelPath: enableSteelPath,
                enableVoidStorm: enableVoidStorm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required int togglesId,
                required int tier,
                required bool enableRegular,
                required bool enableSteelPath,
                required bool enableVoidStorm,
              }) => FissureFiltersCompanion.insert(
                id: id,
                type: type,
                togglesId: togglesId,
                tier: tier,
                enableRegular: enableRegular,
                enableSteelPath: enableSteelPath,
                enableVoidStorm: enableVoidStorm,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FissureFiltersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({togglesId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (togglesId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.togglesId,
                                referencedTable: $$FissureFiltersTableReferences
                                    ._togglesIdTable(db),
                                referencedColumn:
                                    $$FissureFiltersTableReferences
                                        ._togglesIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FissureFiltersTableProcessedTableManager =
    ProcessedTableManager<
      _$SettingsDatabase,
      $FissureFiltersTable,
      FissureFilter,
      $$FissureFiltersTableFilterComposer,
      $$FissureFiltersTableOrderingComposer,
      $$FissureFiltersTableAnnotationComposer,
      $$FissureFiltersTableCreateCompanionBuilder,
      $$FissureFiltersTableUpdateCompanionBuilder,
      (FissureFilter, $$FissureFiltersTableReferences),
      FissureFilter,
      PrefetchHooks Function({bool togglesId})
    >;

class $SettingsDatabaseManager {
  final _$SettingsDatabase _db;
  $SettingsDatabaseManager(this._db);
  $$AppConfigsTableTableManager get appConfigs =>
      $$AppConfigsTableTableManager(_db, _db.appConfigs);
  $$ToggleSettingsTableTableManager get toggleSettings =>
      $$ToggleSettingsTableTableManager(_db, _db.toggleSettings);
  $$CycleFiltersTableTableManager get cycleFilters =>
      $$CycleFiltersTableTableManager(_db, _db.cycleFilters);
  $$FissureFiltersTableTableManager get fissureFilters =>
      $$FissureFiltersTableTableManager(_db, _db.fissureFilters);
}
