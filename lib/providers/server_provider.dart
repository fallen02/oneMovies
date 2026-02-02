import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/servers.dart';
import 'package:onemovies/providers/api_service_provider.dart';

final serverProvider =
    FutureProvider.family.autoDispose<ServerResponse, String>((ref, id) async {
  final api = ref.read(apiServiceProvider);
  return api.fetchServers(id);
});
