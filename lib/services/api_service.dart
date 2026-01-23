import 'package:dio/dio.dart';
import 'package:onemovies/models/home.dart';
import 'package:onemovies/services/api_client.dart';
import '../models/schedule.dart';

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

  String _handleError(DioException e) {
    if (e.response != null) {
      return 'Server error: ${e.response?.statusCode}';
    } else {
      return 'Network error: ${e.message}';
    }
  }
}