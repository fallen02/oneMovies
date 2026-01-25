import 'package:dio/dio.dart';
import 'package:onemovies/models/home.dart';
import 'package:onemovies/models/info.dart';
import 'package:onemovies/models/schedule.dart';
import 'package:onemovies/models/search.dart';
import 'package:onemovies/services/api_client.dart';


class ApiService {
  final Dio _dio = ApiClient().dio;

  Future<ScheduleResponse> fetchSchedule() async {
    try{
      final response = await _dio.get('/schedule');
      return ScheduleResponse.fromJson(response.data);
    } on DioException catch (e){
      throw Exception(_handleError(e));
    }
  }

  Future<HomeResponse> fetchHome() async{
    try{
      final response = await _dio.get('/main');
      return HomeResponse.fromJson(response.data);
    } on DioException catch(e){
      throw Exception(_handleError(e));
    }
  }

  //Fetches Anime Details
  Future<AnimeInfo> fetchInfo(String id) async{
    try{
      final response = await _dio.get('/info/$id');
      return AnimeInfo.fromJson(response.data);
    } on DioException catch(e){
      throw Exception(_handleError(e));
    }
  }

    Future<SearchResponse> search(String query) async{
    try{
      final response = await _dio.get('/search/$query');
      return SearchResponse.fromJson(response.data);
    } on DioException catch(e){
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