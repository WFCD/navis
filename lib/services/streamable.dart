import 'dart:convert';
import 'package:codable/codable.dart';
import 'package:http/http.dart' as http;

import 'package:navis/models/streamable/video.dart';

class StreamableAPI {
  Future<String> fishVideos(String shortCode) async {
    final data = json.decode(
        (await http.get('https://api.streamable.com/videos/$shortCode')).body);
    final key = KeyedArchive.unarchive(data);
    final video = Video()..decode(key);

    return video.files.mp4mobile.url ?? video.files.mp4.url;
  }
}
