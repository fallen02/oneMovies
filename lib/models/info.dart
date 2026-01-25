// To parse this JSON data, do
//
//     final animeInfo = animeInfoFromJson(jsonString);

import 'dart:convert';

AnimeInfo animeInfoFromJson(String str) => AnimeInfo.fromJson(json.decode(str));

String animeInfoToJson(AnimeInfo data) => json.encode(data.toJson());

class AnimeInfo {
  String id;
  String title;
  int malId;
  String japaneseTitle;
  String image;
  String description;
  Type type;
  String pgRationg;
  String quality;
  String duration;
  bool hasSub;
  bool hasDub;
  String totalEps;
  List<String> genres;
  String status;
  String season;
  List<String> studios;
  bool hasMoreSeason;
  List<MoreSeason>? moreSeason;
  List<Recommendation> recommendations;
  List<Recommendation> relatedAnime;

  AnimeInfo({
    required this.id,
    required this.title,
    required this.malId,
    required this.japaneseTitle,
    required this.image,
    required this.description,
    required this.type,
    required this.pgRationg,
    required this.quality,
    this.duration = '0',
    required this.hasSub,
    required this.hasDub,
    required this.totalEps,
    required this.genres,
    required this.status,
    required this.season,
    required this.studios,
    required this.hasMoreSeason,
    this.moreSeason,
    required this.recommendations,
    required this.relatedAnime,
  });

  factory AnimeInfo.fromJson(Map<String, dynamic> json) => AnimeInfo(
    id: json["id"],
    title: json["title"],
    malId: json["malId"],
    japaneseTitle: json["japaneseTitle"],
    image: json["image"],
    description: json["description"],
    type: typeValues.map[json["type"]] ?? Type.TV,
    pgRationg: json["pgRationg"],
    quality: json["quality"],
    duration: json["duration"],

    // ✅ DEFENSIVE BOOL PARSING
    hasSub: json["hasSub"] ?? false,
    hasDub: json["hasDub"] ?? false,
    totalEps: json["totalEps"],
    hasMoreSeason: json["hasMoreSeason"] ?? false,

    genres: List<String>.from(json["genres"].map((x) => x)),
    status: json["status"],
    season: json["season"],
    studios: List<String>.from(json["studios"].map((x) => x)),

    moreSeason: json["moreSeason"] == null
        ? null
        : List<MoreSeason>.from(
            json["moreSeason"].map((x) => MoreSeason.fromJson(x)),
          ),

    recommendations: List<Recommendation>.from(
      json["recommendations"].map((x) => Recommendation.fromJson(x)),
    ),
    relatedAnime: List<Recommendation>.from(
      json["relatedAnime"].map((x) => Recommendation.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "malId": malId,
    "japaneseTitle": japaneseTitle,
    "image": image,
    "description": description,
    "type": typeValues.reverse[type],
    "pgRationg": pgRationg,
    "quality": quality,
    "duration": duration,
    "hasSub": hasSub,
    "hasDub": hasDub,
    "totalEps": totalEps,
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "status": status,
    "season": season,
    "studios": List<dynamic>.from(studios.map((x) => x)),
    "hasMoreSeason": hasMoreSeason,
    "moreSeason": moreSeason == null
        ? null
        : List<dynamic>.from(moreSeason!.map((x) => x.toJson())),
    "recommendations": List<dynamic>.from(
      recommendations.map((x) => x.toJson()),
    ),
    "relatedAnime": List<dynamic>.from(relatedAnime.map((x) => x.toJson())),
  };
}

class MoreSeason {
  String id;
  String title;
  String poster;

  MoreSeason({required this.id, required this.title, required this.poster});

  factory MoreSeason.fromJson(Map<String, dynamic> json) =>
      MoreSeason(id: json["id"], title: json["title"], poster: json["poster"]);

  Map<String, dynamic> toJson() => {"id": id, "title": title, "poster": poster};
}

class Recommendation {
  String id;
  String title;
  String url;
  String image;
  String? duration;
  String japaneseTitle;
  Type type;
  bool? nsfw;
  int sub;
  int dub;
  int episodes;

  Recommendation({
    required this.id,
    required this.title,
    required this.url,
    required this.image,
    this.duration,
    required this.japaneseTitle,
    required this.type,
    this.nsfw,
    required this.sub,
    required this.dub,
    required this.episodes,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    image: json["image"],
    duration: json["duration"],
    japaneseTitle: json["japaneseTitle"],
    type: typeValues.map[json["type"]] ?? Type.TV,
    nsfw: json["nsfw"],
    sub: json["sub"],
    dub: json["dub"],
    episodes: json["episodes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "image": image,
    "duration": duration,
    "japaneseTitle": japaneseTitle,
    "type": typeValues.reverse[type],
    "nsfw": nsfw,
    "sub": sub,
    "dub": dub,
    "episodes": episodes,
  };
}

enum Type { ONA, SPECIAL, TV, MOVIE, TV_SHORT, TV_SPECIAL, OVA, MUSIC }

final typeValues = EnumValues({
  "ONA": Type.ONA,
  "Special": Type.SPECIAL,
  "TV": Type.TV,
  "MOVIE": Type.MOVIE,
  "MUSIC": Type.MUSIC,
  "TV_SHORT": Type.TV_SHORT,
  "TV_SPECIAL": Type.TV_SPECIAL,
  "OVA": Type.OVA,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
