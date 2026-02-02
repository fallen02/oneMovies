import 'package:flutter_riverpod/legacy.dart';
import 'package:onemovies/models/servers.dart';


final selectedTrackProvider = StateProvider.autoDispose<Track?>((ref) => null);