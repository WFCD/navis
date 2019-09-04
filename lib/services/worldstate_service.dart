import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/utils/file_utils.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';
import 'package:worldstate_model/worldstate_models.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class WorldstateService {
  WorldstateService(this.client, this.storage) {
    _api = WorldstateApiWrapper(client);
  }

  final http.Client client;
  final LocalStorageService storage;

  WorldstateApiWrapper _api;

  // Sometimes the items list can be too long and so parsing needs to be moved to a new thread
  // maybe paginat(?) the results in the future
  Future<List<ItemObject>> search(String searchTerm) async {
    return await compute(_search, _SearchItems(_api, searchTerm));
  }

  static Future<List<ItemObject>> _search(_SearchItems search) async {
    final items = await search.api.searchItems(search.searchTerm);

    return items
      ..removeWhere(
        (i) =>
            i.category == 'Skins' ||
            i.category == 'Glyphs' ||
            i.category == 'Misc' ||
            i.wikiaUrl != null,
      );
  }

  Future<Worldstate> getWorldstate([Platforms platform]) async {
    final worldstate =
        await _api.getWorldstate(platform ?? storage.platform ?? Platforms.pc);

    return cleanState(worldstate);
  }

  Future<File> initializeDropTable() async {
    final doesFileExist = await checkFile('/drop_table.json');
    final timestamp = await _getDropTableTimestamp();

    if (doesFileExist != true) {
      try {
        await _downloadDropTable();
        storage.saveTimestamp(timestamp);

        return getFile('/drop_table.json');
      } catch (exception, stack) {
        Crashlytics.instance.recordError(exception, stack);

        return null;
      }
    }

    return getFile('/drop_table.json');
  }

  Future<bool> updateDropTable() async {
    final timestamp = await _getDropTableTimestamp();

    if (timestamp != storage.tableTimestamp) {
      await _downloadDropTable();

      storage.saveTimestamp(timestamp);

      return true;
    }

    return false;
  }

  Future<DateTime> _getDropTableTimestamp() async {
    const infoUrl = 'https://drops.warframestat.us/data/info.json';
    final info = json.decode((await client.get(infoUrl)).body);

    return DateTime.fromMillisecondsSinceEpoch(info['timestamp']);
  }

  Future<void> _downloadDropTable([String path]) async {
    const dropTable = 'https://drops.warframestat.us/data/all.slim.json';

    final response = await client.get(dropTable);

    if (response?.statusCode != 200)
      throw Exception('Drop table failed to download: ${response?.statusCode}');

    await saveFile('/drop_table.json', response.body);
  }
}

class _SearchItems {
  _SearchItems(this.api, this.searchTerm);

  final WorldstateApiWrapper api;
  final String searchTerm;
}
