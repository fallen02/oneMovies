import 'package:dio/dio.dart';
import 'package:onemovies/models/episodes.dart';
import 'package:onemovies/models/home.dart';
import 'package:onemovies/models/info.dart';
import 'package:onemovies/models/schedule.dart';
import 'package:onemovies/models/search.dart';
import 'package:onemovies/models/servers.dart';
import 'package:onemovies/services/api_client.dart';

class ApiService {
  final Dio _dio = ApiClient().dio;

  CancelToken? _searchCancelToken;

  Future<ScheduleResponse> fetchSchedule() async {
    try {
      final response = await _dio.get('/anime/schedule');
      return ScheduleResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<HomeResponse> fetchHome() async {
    try {
      final response = await _dio.get('/anikai/main');
      return HomeResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  //Fetches Anime Details
  Future<InfoResponse> fetchInfo(String id) async {
    try {
      final response = await _dio.get('/anikai/info/$id');
      return InfoResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }
  

  // fetches Anime Episodes
  Future<EpisodeResponse> fetchEpisodes(String id) async {
    try {
      final response = await _dio.get('/anikai/episodes/$id');
      return EpisodeResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // fetches servers of an episode

  Future<ServerResponse> fetchServers(String id) async{
    try {
      final response = await _dio.get('/anikai/server/$id');
      return ServerResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<List<SearchResponse>> search(String query) async {

    _searchCancelToken?.cancel('New Search Started');
    _searchCancelToken = CancelToken();

    try {
      final response = await _dio.get('/search/$query', cancelToken: _searchCancelToken);
      return (response.data as List)
          .map((e) => SearchResponse.fromJson(e))
          .toList();
    } on DioException catch (e) {
      if(CancelToken.isCancel(e)) {
        return [];
      }
      throw Exception(_handleError(e));
    }
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      return 'Server error: ${e.response?.statusCode}';
    } else {
      return 'Network error: ${e.message}';
    }
  }
}
