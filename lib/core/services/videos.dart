import 'package:flutter/foundation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoService {
  Future<VideoInformation> getVideoInformation(String id) async {
    return compute(_getVideoInformation, id);
  }

  static Future<VideoInformation> _getVideoInformation(String id) async {
    final exploded = YoutubeExplode();
    final video = await exploded.videos.get(id);
    final manifest = await exploded.videos.streamsClient.getManifest(id);

    return VideoInformation(
      title: video.title,
      description: video.description,
      author: video.author,
      url: video.url,
      muxedStreamInfo: manifest.muxed.toList(),
    );
  }
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
