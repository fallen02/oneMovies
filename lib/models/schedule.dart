// To parse this JSON data, do
//
//     final scheduleResponse = scheduleResponseFromJson(jsonString);

import 'dart:convert';

ScheduleResponse scheduleResponseFromJson(String str) => ScheduleResponse.fromJson(json.decode(str));

String scheduleResponseToJson(ScheduleResponse data) => json.encode(data.toJson());

class ScheduleResponse {
    List<Result> results;

    ScheduleResponse({
        required this.results,
    });

    factory ScheduleResponse.fromJson(Map<String, dynamic> json) => ScheduleResponse(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String id;
    String title;
    String japaneseTitle;
    String url;
    String airingEpisode;
    String airingTime;

    Result({
        required this.id,
        required this.title,
        required this.japaneseTitle,
        required this.url,
        required this.airingEpisode,
        required this.airingTime,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        japaneseTitle: json["japaneseTitle"],
        url: json["url"],
        airingEpisode: json["airingEpisode"],
        airingTime: json["airingTime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "japaneseTitle": japaneseTitle,
        "url": url,
        "airingEpisode": airingEpisode,
        "airingTime": airingTime,
    };
}
