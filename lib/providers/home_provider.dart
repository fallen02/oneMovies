import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/home.dart';
import 'package:onemovies/providers/api_service_provider.dart';

final homeProvider = FutureProvider<HomeResponse>((ref) async {
  ref.keepAlive();
  final api = ref.read(apiServiceProvider);
  return api.fetchHome();
});