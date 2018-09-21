import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/export.dart';
import 'network/state.dart';
import 'resources/notifications.dart';
import 'ui/animation/countdown.dart';

class NavisModel extends Model {
  final SystemState state = SystemState();
  final Notifications notification = Notifications();
  final fcm = FirebaseMessaging();
  final DateFormat _format = DateFormat.jms().add_yMd();

  bool _isLoading = false;
  bool _hasError = false;
  WorldState worldState;

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  Cetus get cetus => worldState.cetus;

  Earth get earth => worldState.earth;

  Sortie get sortie => worldState.sortie;

  VoidTrader get trader => worldState.trader;

  List<Alerts> get alerts => worldState.alerts;

  List<Events> get events => worldState.events;

  List<VoidFissures> get fissures => worldState.voidFissures;

  List<OrbiterNews> get news => worldState.news;

  List<PersistentEnemies> get enemies => worldState.persistentEnemies;

  List<Syndicates> get syndicates => worldState.syndicates;

  List<Invasions> get invasion => worldState.invasions;

  Stream<Duration> get cetusTime {
    String expiry = worldState.cetus.expiry;
    bool isDay = worldState.cetus.isDay;
    Duration time;

    try {
      time = DateTime.parse(expiry).difference(DateTime.now());
    } catch (err) {
      time = isDay ? Duration(minutes: 100) : Duration(minutes: 50);
    }

    if (expiry == null && isDay) {
      return CounterScreenStream(Duration(minutes: 100));
    } else if (expiry == null && isDay == false) {
      return CounterScreenStream(Duration(minutes: 50));
    } else if (time < Duration.zero && isDay) {
      return CounterScreenStream(Duration(minutes: 100));
    } else if (time < Duration.zero && isDay == false) {
      return CounterScreenStream(Duration(minutes: 50));
    } else {
      return CounterScreenStream(time);
    }
  }

  Stream<Duration> get earthTime => CounterScreenStream(
      DateTime.parse(worldState.earth.expiry).difference(DateTime.now()));

  String get cetusExpiry {
    String expiry;
    Duration day = Duration(minutes: 100);
    Duration night = Duration(minutes: 50);

    try {
      expiry = _format.format(DateTime.parse(worldState.cetus.expiry));
    } catch (err) {
      if (worldState.cetus.isDay)
        expiry = _format.format(DateTime.now().add(day));
      else
        expiry = _format.format(DateTime.now().add(night));
    }

    return expiry;
  }

  String get earthExpiry {
    String expiry;
    Duration cycle = Duration(hours: 4);

    try {
      expiry =
          _format.format(DateTime.parse(worldState.earth.expiry).toLocal());
    } catch (err) {
      if (worldState.earth.isDay)
        expiry = _format.format(DateTime.now().add(cycle));
      else
        expiry = _format.format(DateTime.now().add(cycle));
    }

    return expiry;
  }

  String get arrival =>
      _format.format(DateTime.parse(worldState.trader.activation).toLocal());

  String get departure =>
      _format.format(DateTime.parse(worldState.trader.expiry).toLocal());

  Future<Null> update() async {
    _isLoading = true;
    notifyListeners();

    return state.updateState().then((data) async {
      worldState = data;
      _isLoading = false;
      _hasError = false;
      notifyListeners();
    }).catchError((error) {
      _hasError = true;
      _isLoading = false;
      print('$error');
      notifyListeners();
    });
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    fcm.configure(
      onMessage: (Map<String, dynamic> payload) {
        update();
        notification.alertNotification(worldState.alerts.first);
      },
      onResume: (Map<String, dynamic> payload) => update(),
    );
  }

  static NavisModel of(BuildContext context) =>
      ScopedModel.of<NavisModel>(context);
}
