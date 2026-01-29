import 'dart:convert';

HomeResponse homeResponseFromJson(String str) =>
    HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) =>
    json.encode(data.toJson());

/* ----------------------------- ENUMS ----------------------------- */

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

/* ------------------------- HOME RESPONSE -------------------------- */

class HomeResponse {
  final List<Spotlight> spotlights;
  final List<Trending> trendings;
  final List<Latest> latest;

  HomeResponse({
    required this.spotlights,
    required this.trendings,
    required this.latest,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        spotlights: List<Spotlight>.from(
          json["spotlights"].map((x) => Spotlight.fromJson(x)),
        ),
        trendings: List<Trending>.from(
          json["trendings"].map((x) => Trending.fromJson(x)),
        ),
        latest: List<Latest>.from(
          json["latest"].map((x) => Latest.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "spotlights": spotlights.map((x) => x.toJson()).toList(),
        "trendings": trendings.map((x) => x.toJson()).toList(),
        "latest": latest.map((x) => x.toJson()).toList(),
      };
}

/* --------------------------- SPOTLIGHT ---------------------------- */

class Spotlight {
  final String id;
  final String title;
  final String japaneseTitle;
  final String banner;
  final String url;
  final MediaFormat type;
  final List<String> genres;
  final String releaseDate;
  final String quality;
  final int sub;
  final int dub;
  final String description;

  Spotlight({
    required this.id,
    required this.title,
    required this.japaneseTitle,
    required this.banner,
    required this.url,
    required this.type,
    required this.genres,
    required this.releaseDate,
    required this.quality,
    required this.sub,
    required this.dub,
    required this.description,
  });

  factory Spotlight.fromJson(Map<String, dynamic> json) => Spotlight(
        id: json["id"],
        title: json["title"],
        japaneseTitle: json["japaneseTitle"],
        banner: json["banner"],
        url: json["url"],
        type: mediaFormatValues.map[json["type"]]!,
        genres: List<String>.from(json["genres"]),
        releaseDate: json["releaseDate"],
        quality: json["quality"],
        sub: json["sub"],
        dub: json["dub"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "japaneseTitle": japaneseTitle,
        "banner": banner,
        "url": url,
        "type": mediaFormatValues.reverse[type],
        "genres": genres,
        "releaseDate": releaseDate,
        "quality": quality,
        "sub": sub,
        "dub": dub,
        "description": description,
      };
}

/* ----------------------------- LATEST ----------------------------- */

class Latest {
  final String id;
  final String poster;
  final String title;
  final String jpTitle;
  final MediaFormat mediaType;
  final int? sub;
  final int? dub;

  Latest({
    required this.id,
    required this.poster,
    required this.title,
    required this.jpTitle,
    required this.mediaType,
    this.sub,
    this.dub,
  });

  factory Latest.fromJson(Map<String, dynamic> json) => Latest(
        id: json["id"],
        poster: json["poster"],
        title: json["title"],
        jpTitle: json["jpTitle"],
        mediaType: mediaFormatValues.map[json["mediaType"]]!,
        sub: json["sub"],
        dub: json["dub"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster": poster,
        "title": title,
        "jpTitle": jpTitle,
        "mediaType": mediaFormatValues.reverse[mediaType],
        "sub": sub,
        "dub": dub,
      };
}

/* ---------------------------- TRENDING ---------------------------- */

class Trending {
  final String type; // trending | day | week | month
  final List<TrendingItem> data;

  Trending({
    required this.type,
    required this.data,
  });

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(
        type: json["type"],
        data: List<TrendingItem>.from(
          json["data"].map((x) => TrendingItem.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class TrendingItem {
  final String id;
  final String poster;
  final String title;
  final String jpTitle;
  final MediaFormat type;
  final int? sub;
  final int? dub;

  TrendingItem({
    required this.id,
    required this.poster,
    required this.title,
    required this.jpTitle,
    required this.type,
    this.sub,
    this.dub,
  });

  factory TrendingItem.fromJson(Map<String, dynamic> json) => TrendingItem(
        id: json["id"],
        poster: json["poster"],
        title: json["title"],
        jpTitle: json["jpTitle"],
        type: mediaFormatValues.map[json["type"]]!,
        sub: json["sub"],
        dub: json["dub"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster": poster,
        "title": title,
        "jpTitle": jpTitle,
        "type": mediaFormatValues.reverse[type],
        "sub": sub,
        "dub": dub,
      };
}

/* -------------------------- ENUM HELPER --------------------------- */

class EnumValues<T> {
  final Map<String, T> map;
  Map<T, String>? _reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    _reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return _reverseMap!;
  }
}
