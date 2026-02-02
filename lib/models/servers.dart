import 'dart:convert';
ServerResponse serverResponseFromJson(String str) =>
    ServerResponse.fromJson(json.decode(str));

String serverResponseToJson(ServerResponse data) =>
    json.encode(data.toJson());

class ServerResponse {
  final List<Track> sub;
  final List<Track> dub;
  final List<Track> hardsub;

  const ServerResponse({
    required this.sub,
    required this.dub,
    required this.hardsub,
  });

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(
      sub: _parseTrackList(json['sub']),
      dub: _parseTrackList(json['dub']),
      hardsub: _parseTrackList(json['hardsub']),
    );
  }

  Map<String, dynamic> toJson() => {
        'sub': sub.map((e) => e.toJson()).toList(),
        'dub': dub.map((e) => e.toJson()).toList(),
        'hardsub': hardsub.map((e) => e.toJson()).toList(),
      };

  static List<Track> _parseTrackList(dynamic value) {
    if (value is! List) return const [];

    return value
        .whereType<Map<String, dynamic>>()
        .map(Track.fromJson)
        .toList(growable: false);
  }
}

class Track {
  final String name;
  final String url;
  final Segment intro;
  final Segment outro;

  const Track({
    required this.name,
    required this.url,
    required this.intro,
    required this.outro,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
      intro: json['intro'] is Map<String, dynamic>
          ? Segment.fromJson(json['intro'])
          : const Segment(start: 0, end: 0),
      outro: json['outro'] is Map<String, dynamic>
          ? Segment.fromJson(json['outro'])
          : const Segment(start: 0, end: 0),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'url': url,
    'intro': intro.toJson(),
    'outro': outro.toJson(),
  };
}

class Segment {
  final int start;
  final int end;

  const Segment({required this.start, required this.end});

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      start: json['start'] as int? ?? 0,
      end: json['end'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'start': start, 'end': end};
}

