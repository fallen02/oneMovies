import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/search.dart';
import 'package:onemovies/providers/api_service_provider.dart';

final infoProvider = FutureProvider.family<SearchResponse, String>((ref, query) async {
  ref.keepAlive();
  final api = ref.read(apiServiceProvider);
  return api.search(query);
});