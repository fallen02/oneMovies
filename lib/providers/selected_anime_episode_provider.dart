import 'package:flutter_riverpod/legacy.dart';
import 'package:onemovies/models/episodes.dart';


final selectedAnimeEpisodeProvider = StateProvider.autoDispose<Episode?>((ref) => null);