import 'package:codable/codable.dart';

class Video extends Coding {
  int status;
  Files files;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    status = object.decode('status');
    files = object.decodeObject('files', () => Files());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('status', status);
    object.encodeObject('files', files);
  }
}

class Files extends Coding {
  MP4 mp4, mp4mobile;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    mp4 = object.decodeObject('mp4', () => MP4());
    mp4mobile = object.decodeObject('mp4-mobile', () => MP4());
  }

  @override
  void encode(KeyedArchive object) {
    object.encodeObject('mp4', mp4);
    object.encodeObject('mp4-mobile', mp4mobile);
  }
}

class MP4 extends Coding {
  int status, width, height, bitrate, framerate, size;
  double duration;
  String url;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    // I'm allowed to do this right?
    url = 'https:${object.decode('url')}';

    status = object.decode('status');
    width = object.decode('width');
    height = object.decode('height');
    bitrate = object.decode('bitrate');
    duration = object.decode('duration');
    framerate = object.decode('framerate');
    size = object.decode('size');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('status', status);
    object.encode('width', width);
    object.encode('height', height);
    object.encode('bitrate', bitrate);
    object.encode('duration', duration);
    object.encode('framerate', framerate);
    object.encode('size', size);

    object.encode('url', url);
  }
}
