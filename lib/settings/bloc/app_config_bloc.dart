import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis_settings/navis_settings.dart';

part 'app_config_event.dart';
part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc(SettingsDatabase db) : _appConfig = AppConfigAccessor(db), super(AppConfigInitial()) {
    on<AppConfigSubscriptionRequested>(_onAppConfigSubReq);
    on(_updateSettings);
  }

  final AppConfigAccessor _appConfig;

  Future<void> _updateSettings(AppConfigUpdate event, Emitter<AppConfigState> emit) async {
    await _appConfig.updateSettings(
      language: event.language,
      theme: event.theme,
      optOut: event.optOut,
      account: event.account,
    );
  }

  Future<void> _onAppConfigSubReq(AppConfigEvent event, Emitter<AppConfigState> emit) async {
    return emit.onEach(
      _appConfig.watchSettings(),
      onData: (settings) => emit(AppConfigUpdated(config: settings)),
      onError: addError,
    );
  }
}
