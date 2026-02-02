import 'package:flutter_riverpod/legacy.dart';

enum ServerType { sub, dub, hardsub }

final selectedServerTypeProvider =
    StateProvider<ServerType?>((ref) => ServerType.sub);

// final selectedServerPovider = StateProvider<>((ref) => null)