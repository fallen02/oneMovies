import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/episodes.dart';
import 'package:onemovies/providers/api_service_provider.dart';

final episodeProvider = FutureProvider.family<EpisodeResponse, String>((
  ref,
  id,
) async {
  ref.keepAlive();
  final api = ref.read(apiServiceProvider);
  return api.fetchEpisodes(id);
});
