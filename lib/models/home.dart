import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
    List<Spotlight> spotlights;
    List<Trending> trendings;
    List<LatestEpisode> latestEpisodes;
    TopAnime topAnime;

    HomeResponse({
        required this.spotlights,
        required this.trendings,
        required this.latestEpisodes,
        required this.topAnime,
    });

    factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        spotlights: List<Spotlight>.from(json["spotlights"].map((x) => Spotlight.fromJson(x))),
        trendings: List<Trending>.from(json["trendings"].map((x) => Trending.fromJson(x))),
        latestEpisodes: List<LatestEpisode>.from(json["latestEpisodes"].map((x) => LatestEpisode.fromJson(x))),
        topAnime: TopAnime.fromJson(json["topAnime"]),
    );

    Map<String, dynamic> toJson() => {
        "spotlights": List<dynamic>.from(spotlights.map((x) => x.toJson())),
        "trendings": List<dynamic>.from(trendings.map((x) => x.toJson())),
        "latestEpisodes": List<dynamic>.from(latestEpisodes.map((x) => x.toJson())),
        "topAnime": topAnime.toJson(),
    };
}

class LatestEpisode {
    String id;
    String episodeNo;
    String title;
    Type type;
    String runtime;
    String poster;

    LatestEpisode({
        required this.id,
        required this.episodeNo,
        required this.title,
        required this.type,
        required this.runtime,
        required this.poster,
    });

    factory LatestEpisode.fromJson(Map<String, dynamic> json) => LatestEpisode(
        id: json["id"],
        episodeNo: json["episodeNo"],
        title: json["title"],
        type: typeValues.map[json["type"]]!,
        runtime: json["runtime"],
        poster: json["poster"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "episodeNo": episodeNo,
        "title": title,
        "type": typeValues.reverse[type],
        "runtime": runtime,
        "poster": poster,
    };
}

enum Type {
    ONA,
    TV
}

final typeValues = EnumValues({
    "ONA": Type.ONA,
    "TV": Type.TV
});

class Spotlight {
    String id;
    String title;
    String japaneseTitle;
    String banner;
    int rank;
    String url;
    Type type;
    String duration;
    String releaseDate;
    String quality;
    int sub;
    int dub;
    int episodes;
    String description;

    Spotlight({
        required this.id,
        required this.title,
        required this.japaneseTitle,
        required this.banner,
        required this.rank,
        required this.url,
        required this.type,
        required this.duration,
        required this.releaseDate,
        required this.quality,
        required this.sub,
        required this.dub,
        required this.episodes,
        required this.description,
    });

    factory Spotlight.fromJson(Map<String, dynamic> json) => Spotlight(
        id: json["id"],
        title: json["title"],
        japaneseTitle: json["japaneseTitle"],
        banner: json["banner"],
        rank: json["rank"],
        url: json["url"],
        type: typeValues.map[json["type"]]!,
        duration: json["duration"],
        releaseDate: json["releaseDate"],
        quality: json["quality"],
        sub: json["sub"],
        dub: json["dub"],
        episodes: json["episodes"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "japaneseTitle": japaneseTitle,
        "banner": banner,
        "rank": rank,
        "url": url,
        "type": typeValues.reverse[type],
        "duration": duration,
        "releaseDate": releaseDate,
        "quality": quality,
        "sub": sub,
        "dub": dub,
        "episodes": episodes,
        "description": description,
    };
}

class TopAnime {
    List<Month> today;
    List<Month> week;
    List<Month> month;

    TopAnime({
        required this.today,
        required this.week,
        required this.month,
    });

    factory TopAnime.fromJson(Map<String, dynamic> json) => TopAnime(
        today: List<Month>.from(json["today"].map((x) => Month.fromJson(x))),
        week: List<Month>.from(json["week"].map((x) => Month.fromJson(x))),
        month: List<Month>.from(json["month"].map((x) => Month.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "today": List<dynamic>.from(today.map((x) => x.toJson())),
        "week": List<dynamic>.from(week.map((x) => x.toJson())),
        "month": List<dynamic>.from(month.map((x) => x.toJson())),
    };
}

class Month {
    String id;
    String title;
    String poster;

    Month({
        required this.id,
        required this.title,
        required this.poster,
    });

    factory Month.fromJson(Map<String, dynamic> json) => Month(
        id: json["id"],
        title: json["title"],
        poster: json["poster"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "poster": poster,
    };
}

class Trending {
    String number;
    String id;
    String title;

    Trending({
        required this.number,
        required this.id,
        required this.title,
    });

    factory Trending.fromJson(Map<String, dynamic> json) => Trending(
        number: json["number"],
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "id": id,
        "title": title,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
