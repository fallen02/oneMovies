import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/servers.dart';
import 'package:onemovies/providers/selected_track_provider.dart';
import 'package:onemovies/providers/server_provider.dart';

final initialTrackProvider =
    Provider.family<Track?, String>((ref, id) {
  final serverAsync = ref.watch(serverProvider(id));

  return serverAsync.maybeWhen(
    data: (server) {
      if (server.sub.isNotEmpty) return ref.read(selectedTrackProvider.notifier).state = server.sub.first;
      if (server.dub.isNotEmpty) return ref.read(selectedTrackProvider.notifier).state = server.dub.first;
      if (server.hardsub.isNotEmpty) return ref.read(selectedTrackProvider.notifier).state = server.hardsub.first;
      return null;
    },
    orElse: () => null,
  );
});
