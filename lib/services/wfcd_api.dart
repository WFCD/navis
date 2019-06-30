import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:navis/models/drop_tables/slim.dart';
import 'package:navis/models/export.dart';
import 'package:navis/services/services.dart';
import 'package:navis/utils/decoding_utils.dart';
import 'package:navis/utils/enums.dart';

import 'localstorage_service.dart';

const String statusUrl = 'https://api.warframestat.us';
const String dropTableUrl = 'https://drops.warframestat.us';

class WFCD {
  final warframestat = Dio()
    ..options.baseUrl = statusUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  static final _storageService = locator<LocalStorageService>();

  Future<Worldstate> getWorldstate(Platforms platform) async {
    platform ??= Platforms.pc;
    Map worldstate;

    try {
      final response =
          await warframestat.request('/${platform.toString().split('.').last}');

      worldstate = response.data;
    } on SocketException {
      return Worldstate();
    }

    return jsonToWorldstate(worldstate);
  }

  Future<List<Drop>> getDropTable(
      File source, DateTime timestamp, DateTime local) async {
    if (timestamp.isAfter(local) || source.existsSync() == false) {
      _storageService.saveTimestamp(timestamp);

      try {
        final request = await warframestat.request('/drops');

        await source.writeAsString(json.encode(request.data));

        return await compute(jsonToRewards, await source.readAsString());
      } on SocketException {
        final slim = await rootBundle.loadString('assets/slim.json');

        source.writeAsStringSync(slim);
        return await compute(jsonToRewards, slim);
      }
    }

    return await compute(jsonToRewards, source.readAsStringSync());
  }
}
