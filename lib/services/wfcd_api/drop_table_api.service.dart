import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:navis/services/storage/cache_storage.service.dart';
import 'package:navis/utils/file_utils.dart';
import 'package:wfcd_api_wrapper/worldstate_client.dart';

class DropTableApiService {
  static const dropTablePath = '/drop_table.json';

  final _cache = CacheStorageService.instance;

  Future<File> get dropTable async => await getFile(dropTablePath);

  Future<File> initializeDropTable() async {
    final doesFileExist = await checkFile(dropTablePath);
    final timestamp = await _getDropTableTimestamp();

    if (!doesFileExist) {
      await _downloadDropTable();
      _cache.saveDropTableTimestamp(timestamp);

      return await getFile(dropTablePath);
    }

    return await getFile(dropTablePath);
  }

  Future<bool> updateDropTable() async {
    final timestamp = await _getDropTableTimestamp();

    if (timestamp != _cache.getDropTableTimestamp) {
      await _downloadDropTable();
      _cache.saveDropTableTimestamp(timestamp);

      return true;
    }

    return false;
  }

  Future<DateTime> _getDropTableTimestamp() async {
    const infoUrl = 'https://drops.warframestat.us/data/info.json';
    final info = json.decode((await http.get(infoUrl)).body);

    return DateTime.fromMillisecondsSinceEpoch(info['timestamp']);
  }

  Future<void> _downloadDropTable([String path]) async {
    const dropTable = 'https://drops.warframestat.us/data/all.slim.json';

    final response = await http.get(dropTable);

    if (response?.statusCode != 200)
      throw FetchDataException('Drop table failed to download.');

    if (!response.body.startsWith('['))
      throw const FormatException('Invalid drop table provided by API');

    await saveFile(
        SaveFile(await tempDirectory() + dropTablePath, response.body));
  }
}
