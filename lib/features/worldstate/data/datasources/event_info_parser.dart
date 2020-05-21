import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:navis/features/worldstate/data/models/event_info.dart';
import 'package:navis/features/worldstate/domain/entities/event_info.dart';

class EventInfoParser {
  const EventInfoParser._(this.eventInfo);

  final Map<String, EventInfo> eventInfo;

  static EventInfoParser _instance;

  static Future<EventInfoParser> loadEventData() async {
    if (_instance != null) return _instance;

    final asset = await rootBundle.loadString('assets/event_info.json');
    final info = (json.decode(asset) as Map<String, dynamic>)
        .map<String, EventInfo>((name, dynamic info) => MapEntry(
            name, EventInfoModel.fromJson(info as Map<String, dynamic>)));

    return EventInfoParser._(info);
  }
}
