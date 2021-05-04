class EventInfo {
  const EventInfo({required this.keyArt, required this.howTos});

  final String keyArt;
  final List<HowTo> howTos;
}

class HowTo {
  const HowTo({
    required this.id,
    required this.pThumbnail,
  });

  final String id;
  final String pThumbnail;
}
