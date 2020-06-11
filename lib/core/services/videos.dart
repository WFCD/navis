import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoService {
  final _exploded = YoutubeExplode();

  Future<VideoInformation> getVideoInformation(String id) async {
    final video = await _exploded.videos.get(id);
    final manifest = await _exploded.videos.streamsClient.getManifest(id);

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
    this.title,
    this.description,
    this.author,
    this.url,
    this.muxedStreamInfo,
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
