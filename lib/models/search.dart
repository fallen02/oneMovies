// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

List<SearchResponse> searchResponseFromJson(String str) => List<SearchResponse>.from(json.decode(str).map((x) => SearchResponse.fromJson(x)));

String searchResponseToJson(List<SearchResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchResponse {
  String id;
  String title;
  String url;
  String image;
  String? duration;
  String japaneseTitle;
  Type type;
  bool nsfw;
  int sub;
  int dub;
  int episodes;

  SearchResponse({
    required this.id,
    required this.title,
    required this.url,
    required this.image,
    this.duration,
    required this.japaneseTitle,
    required this.type,
    required this.nsfw,
    required this.sub,
    required this.dub,
    required this.episodes,
  });

  static Type parseType(dynamic value) {
  if (value == null) return Type.TV;

  final key = value.toString().toUpperCase();
  return typeValues.map[key] ?? Type.TV;
}

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      SearchResponse(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        image: json["image"],
        duration: json["duration"], // nullable-safe
        japaneseTitle: json["japaneseTitle"],
        type: parseType(json["type"]), // ✅ SAFE
        nsfw: json["nsfw"] ?? false,
        sub: json["sub"] ?? 0,
        dub: json["dub"] ?? 0,
        episodes: json["episodes"] ?? 0,
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

enum Type {
    ONA,
    SPECIAL,
    TV,
    MOVIE,
    TV_SHORT,
    TV_SPECIAL,
    OVA,
    MUSIC,
}

final typeValues = EnumValues({
  "ONA": Type.ONA,
  "SPECIAL": Type.SPECIAL,
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
