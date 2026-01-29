import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/info.dart';
import 'package:onemovies/providers/api_service_provider.dart';

final infoProvider = FutureProvider.family<InfoResponse, String>((ref, id) async {

  ref.keepAlive();
  final api = ref.read(apiServiceProvider);
  return api.fetchInfo(id);
});