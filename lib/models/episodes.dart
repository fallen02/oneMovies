// To parse this JSON data, do
//
//     final episodeResponse = episodeResponseFromJson(jsonString);

import 'dart:convert';

EpisodeResponse episodeResponseFromJson(String str) =>
    EpisodeResponse.fromJson(json.decode(str));

String episodeResponseToJson(EpisodeResponse data) =>
    json.encode(data.toJson());

class EpisodeResponse {
  final int totalEps;
  final List<Episode> episodes;

  const EpisodeResponse({required this.totalEps, required this.episodes});

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) {
    final rawEpisodes = json['episodes'];

    final episodes = rawEpisodes is List
        ? rawEpisodes
              .whereType<Map<String, dynamic>>()
              .map(Episode.fromJson)
              .toList(growable: false)
        : <Episode>[];

    return EpisodeResponse(
      totalEps: json['totalEps'] ?? episodes.length,
      episodes: episodes,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalEps': totalEps,
    'episodes': episodes.map((e) => e.toJson()).toList(),
  };
}

class Episode {
  String id;
  int number;
  String title;
  bool isFiller;
  String url;

  Episode({
    required this.id,
    required this.number,
    required this.title,
    required this.isFiller,
    required this.url,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    id: json["id"],
    number: json["number"],
    title: json["title"],
    isFiller: json["isFiller"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "title": title,
    "isFiller": isFiller,
    "url": url,
  };
}
