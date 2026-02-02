import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/sources.dart';
import 'package:onemovies/providers/selected_track_provider.dart';
import 'package:onemovies/utils/macros/extract_link.dart';

final streamLinkProvider = FutureProvider.autoDispose<ISource?>((ref) async {
  final track = ref.watch(selectedTrackProvider);

if (track == null || track.url.isEmpty) {
  throw Exception('Invalid track URL');
}

return linkExtractor(Uri.parse(track.url));
});
