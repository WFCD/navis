import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:retry/retry.dart';

class VideoService {
  VideoService({YoutubeHttpClient? youtubeHttpClient})
      : _youtubeHttpClient = youtubeHttpClient ?? YoutubeHttpClient();

  final YoutubeHttpClient _youtubeHttpClient;

  Future<VideoInformation?> getVideoInformation(String id) async {
    final request = VideoRequest(_youtubeHttpClient, id);
    return compute(_getVideoInformation, request);
  }

  static const _timeout = Duration(seconds: 5);

  static Future<VideoInformation?> _getVideoInformation(
      VideoRequest request) async {
    final exploded = YoutubeExplode(request.client);

    try {
      return retry<VideoInformation?>(
        () async {
          final video = await exploded.videos.get(request.id).timeout(_timeout);
          final manifest = await exploded.videos.streamsClient
              .getManifest(request.id)
              .timeout(_timeout);

          return VideoInformation(
            video: video,
            muxedStreamInfos: manifest.muxed.toList(),
          );
        },
        retryIf: _shouldRetry,
      );
    } catch (e) {
      return null;
    }
  }

  static bool _shouldRetry(e) =>
      e is SocketException ||
      e is TimeoutException ||
      e is FatalFailureException ||
      e is RequestLimitExceededException;
}

class VideoRequest {
  const VideoRequest(this.client, this.id);

  final YoutubeHttpClient client;
  final String id;
}

class VideoInformation {
  const VideoInformation({
    required Video video,
    required List<MuxedStreamInfo> muxedStreamInfos,
  })  : _video = video,
        _muxedStreamInfos = muxedStreamInfos;

  final Video _video;
  final List<MuxedStreamInfo> _muxedStreamInfos;

  String get title => _video.title;
  String get description => _video.description;
  String get author => _video.author;
  String get url => _video.url;

  MuxedStreamInfo get video {
    return _muxedStreamInfos
        .firstWhere((e) => e.videoQuality == VideoQuality.high720);
  }

  double get aspectRatio {
    return video.videoResolution.width / video.videoResolution.height;
  }
}
