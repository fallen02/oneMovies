class VideoSource {
  final String url;
  final bool isM3U8;

  VideoSource({required this.url, required this.isM3U8});
}

class Subtitle {
  final String kind;
  final String url;
  final String lang;

  Subtitle({required this.kind, required this.url, required this.lang});
}

class ISource {
  final List<VideoSource> sources;
  final List<Subtitle> subtitles;
  final dynamic download;
  final String refferer;

  ISource({
    required this.sources,
    required this.subtitles,
    required this.refferer,
    this.download,
  });
}
