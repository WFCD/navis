import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_settings/src/cubit/user_setting_cubit.dart';
import 'package:user_settings/src/user_settings.dart';

/// {@template usersettingswidget}
/// Simple wrapper to provide [UserSettings] to the widget tree.
/// {@endtemplate}
class UserSettingsWidget extends StatelessWidget {
  /// {@macro usersettingswidget}
  const UserSettingsWidget({
    super.key,
    required this.settings,
    required this.child,
  });

  final UserSettings settings;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserSettingsCubit(settings),
      child: child,
    );
  }
}
