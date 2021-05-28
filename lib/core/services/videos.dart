import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:retry/retry.dart';

class VideoService {
  Future<VideoInformation> getVideoInformation(String id) async {
    return compute(_getVideoInformation, id);
  }

  static const _timeout = Duration(seconds: 5);

  static Future<VideoInformation> _getVideoInformation(String id) async {
    final exploded = YoutubeExplode();

    final video = await retry(
      () => exploded.videos.get(id).timeout(_timeout),
      retryIf: _shouldRetry,
    );
    final manifest = await retry(
      () => exploded.videos.streamsClient.getManifest(id).timeout(_timeout),
      retryIf: _shouldRetry,
    );

    return VideoInformation(
      title: video.title,
      description: video.description,
      author: video.author,
      url: video.url,
      muxedStreamInfo: manifest.muxed.toList(),
    );
  }

  static bool _shouldRetry(e) =>
      e is SocketException ||
      e is TimeoutException ||
      e is FatalFailureException ||
      e is RequestLimitExceededException;
}

class VideoInformation {
  const VideoInformation({
    required this.title,
    required this.description,
    required this.author,
    required this.url,
    required this.muxedStreamInfo,
  });

  final String title, description, author, url;
  final List<MuxedStreamInfo> muxedStreamInfo;

  MuxedStreamInfo get video {
    return muxedStreamInfo
        .firstWhere((element) => element.videoQuality == VideoQuality.high720);
  }

  double get aspectRatio {
    return video.videoResolution.width / video.videoResolution.height;
  }
}
