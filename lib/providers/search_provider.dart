import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/search.dart';
import 'package:onemovies/providers/api_service_provider.dart';

final searchProvider = FutureProvider.autoDispose.family<List<SearchResponse>, String>((ref, query) async {

  if(query.trim().isEmpty) return [];
  final api = ref.read(apiServiceProvider);
  return api.search(query);
});

