import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/schedule.dart';
import 'package:onemovies/providers/api_service_provider.dart';

final scheduleProvider = FutureProvider<ScheduleResponse>((ref) async {
  ref.keepAlive();
  final api = ref.read(apiServiceProvider);
  return api.fetchSchedule();
});