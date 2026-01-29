import 'dart:convert';

InfoResponse infoResponseFromJson(String str) =>
    InfoResponse.fromJson(json.decode(str));

String infoResponseToJson(InfoResponse data) =>
    json.encode(data.toJson());

class InfoResponse {
  final String id;
  final String aniId;
  final String title;
  final String japaneseTitle;
  final String poster;
  final String description;
  final MediaFormat type;
  final String url;
  final bool hasSub;
  final bool hasDub;
  final int subEps;
  final int dubEps;
  final String season;
  final List<String> genres;
  final List<Recommendation> recommendations;
  final List<Relation> relations;

  InfoResponse({
    required this.id,
    required this.aniId,
    required this.title,
    required this.japaneseTitle,
    required this.poster,
    required this.description,
    required this.type,
    required this.url,
    required this.hasSub,
    required this.hasDub,
    required this.subEps,
    required this.dubEps,
    required this.season,
    required this.genres,
    required this.recommendations,
    required this.relations,
  });

  factory InfoResponse.fromJson(Map<String, dynamic> json) => InfoResponse(
        id: json["id"],
        aniId: json["ani_id"],
        title: json["title"],
        japaneseTitle: json["japaneseTitle"],
        poster: json["poster"],
        description: json["description"],
        type: mediaFormatValues.map[json["type"]]!,
        url: json["url"],
        hasSub: json["hasSub"],
        hasDub: json["hasDub"],
        subEps: json["subEps"],
        dubEps: json["dubEps"],
        season: json["season"],
        genres: List<String>.from(json["genres"]),
        recommendations: List<Recommendation>.from(
          json["recommendations"].map((x) => Recommendation.fromJson(x)),
        ),
        relations: List<Relation>.from(
          json["relations"].map((x) => Relation.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ani_id": aniId,
        "title": title,
        "japaneseTitle": japaneseTitle,
        "poster": poster,
        "description": description,
        "type": mediaFormatValues.reverse[type],
        "url": url,
        "hasSub": hasSub,
        "hasDub": hasDub,
        "subEps": subEps,
        "dubEps": dubEps,
        "season": season,
        "genres": genres,
        "recommendations":
            recommendations.map((x) => x.toJson()).toList(),
        "relations": relations.map((x) => x.toJson()).toList(),
      };
}

/* -------------------- RECOMMENDATION -------------------- */

class Recommendation {
  final String id;
  final String title;
  final String url;
  final String image;
  final String japaneseTitle;
  final MediaFormat type;
  final int sub;
  final int dub;
  final int episodes;

  Recommendation({
    required this.id,
    required this.title,
    required this.url,
    required this.image,
    required this.japaneseTitle,
    required this.type,
    required this.sub,
    required this.dub,
    required this.episodes,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        image: json["image"],
        japaneseTitle: json["japaneseTitle"],
        type: mediaFormatValues.map[json["type"]]!,
        sub: json["sub"],
        dub: json["dub"],
        episodes: json["episodes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "image": image,
        "japaneseTitle": japaneseTitle,
        "type": mediaFormatValues.reverse[type],
        "sub": sub,
        "dub": dub,
        "episodes": episodes,
      };
}

/* ------------------------ RELATION ----------------------- */

class Relation {
  final bool isActive;
  final String id;
  final String poster;
  final String title;
  final int eps;

  Relation({
    required this.isActive,
    required this.id,
    required this.poster,
    required this.title,
    required this.eps,
  });

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        isActive: json["isActive"],
        id: json["id"],
        poster: json["poster"],
        title: json["title"],
        eps: json["eps"],
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "id": id,
        "poster": poster,
        "title": title,
        "eps": eps,
      };
}

enum MediaFormat {
  TV,
  TV_SHORT,
  TV_SPECIAL,
  MOVIE,
  SPECIAL,
  OVA,
  ONA,
}

final mediaFormatValues = EnumValues({
  "TV": MediaFormat.TV,
  "TV_SHORT": MediaFormat.TV_SHORT,
  "TV_SPECIAL": MediaFormat.TV_SPECIAL,
  "MOVIE": MediaFormat.MOVIE,
  "SPECIAL": MediaFormat.SPECIAL,
  "OVA": MediaFormat.OVA,
  "ONA": MediaFormat.ONA,
});

class EnumValues<T> {
  final Map<String, T> map;
  Map<T, String>? _reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    _reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return _reverseMap!;
  }
}
