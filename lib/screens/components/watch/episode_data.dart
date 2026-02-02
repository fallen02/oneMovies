import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/servers.dart';

import 'package:onemovies/providers/selected_anime_episode_provider.dart';
import 'package:onemovies/providers/selected_server_type_provider.dart';
import 'package:onemovies/providers/selected_track_provider.dart';
import 'package:onemovies/providers/server_provider.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class EpisodeData extends ConsumerStatefulWidget {
  const EpisodeData({super.key});

  @override
  ConsumerState<EpisodeData> createState() => _EpisodeDataState();
}

class _EpisodeDataState extends ConsumerState<EpisodeData> {
  @override
  void initState() {
    super.initState();

    ref.listenManual(selectedAnimeEpisodeProvider, (_, episode) {
      if (episode == null) return;

      ServerType resolveServerType(ServerResponse server, ServerType current) {
        if (current == ServerType.sub && server.sub.isNotEmpty) {
          return ServerType.sub;
        }
        if (current == ServerType.dub && server.dub.isNotEmpty) {
          return ServerType.dub;
        }
        if (current == ServerType.hardsub && server.hardsub.isNotEmpty) {
          return ServerType.hardsub;
        }

        // fallback priority
        if (server.sub.isNotEmpty) return ServerType.sub;
        if (server.dub.isNotEmpty) return ServerType.dub;
        if (server.hardsub.isNotEmpty) return ServerType.hardsub;

        throw Exception('No servers available');
      }

      ref.listenManual(serverProvider(episode.id), (_, next) {
        next.whenData((server) {
          final selectedType = ref.read(selectedServerTypeProvider);
          final currentTrack = ref.read(selectedTrackProvider);

          final resolvedType = resolveServerType(server, selectedType);

          if (resolvedType != selectedType) {
            ref.read(selectedServerTypeProvider.notifier).state = resolvedType;
          }

          final tracks = switch (resolvedType) {
            ServerType.sub => server.sub,
            ServerType.dub => server.dub,
            ServerType.hardsub => server.hardsub,
          };

          if (tracks.isNotEmpty && !tracks.contains(currentTrack)) {
            ref.read(selectedTrackProvider.notifier).state = tracks.first;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final episode = ref.watch(selectedAnimeEpisodeProvider);

    if (episode == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final serverAsync = ref.watch(serverProvider(episode.id));
    final selectedType = ref.watch(selectedServerTypeProvider);

    return serverAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (server) {
        final tracks = switch (selectedType) {
          ServerType.sub => server.sub,
          ServerType.dub => server.dub,
          ServerType.hardsub => server.hardsub,
          _ => const [],
        };

        return Column(
          spacing: 15,
          children: [
            // server badges
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (server.sub.isNotEmpty)
                  _ServerBadge(
                    text: "Sub",
                    selected: selectedType == ServerType.sub,
                    onTap: () => {
                      ref.read(selectedServerTypeProvider.notifier).state =
                          ServerType.sub,
                      ref.read(selectedTrackProvider.notifier).state =
                          server.sub[0],
                    },
                  ),
                if (server.dub.isNotEmpty)
                  _ServerBadge(
                    text: "Dub",
                    type: BadgeType2.dub,
                    selected: selectedType == ServerType.dub,
                    onTap: () => {
                      ref.read(selectedServerTypeProvider.notifier).state =
                          ServerType.dub,
                      ref.read(selectedTrackProvider.notifier).state =
                          server.dub[0],
                    },
                  ),
                if (server.hardsub.isNotEmpty)
                  _ServerBadge(
                    text: "Hard Sub",
                    selected: selectedType == ServerType.hardsub,
                    onTap: () => {
                      ref.read(selectedServerTypeProvider.notifier).state =
                          ServerType.hardsub,
                      ref.read(selectedTrackProvider.notifier).state =
                          server.hardsub[0],
                    },
                  ),
              ],
            ),

            tracks.isEmpty
                ? const Text("No servers available")
                : Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: tracks.map((track) {
                      return InkWell(
                        onTap: () =>
                            ref.read(selectedTrackProvider.notifier).state =
                                track,
                        child: Container(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            track.name,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        );
      },
    );
  }
}

enum BadgeType2 { sub, dub }

class _ServerBadge extends StatelessWidget {
  final String text;
  final bool selected;
  final BadgeType2 type;
  final VoidCallback onTap;

  const _ServerBadge({
    required this.text,
    required this.selected,
    required this.onTap,
    this.type = BadgeType2.sub,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final background = selected
        ? colors.primary
        : colors.primary.withValues(alpha: 0.25);

    final textColor = selected ? colors.onPrimary : colors.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: colors.primary),
          ),
          child: Row(
            spacing: 10,
            children: [
              Icon(
                type == BadgeType2.sub
                    ? Broken.creative_commons
                    : Broken.microphone_2,

                size: 13,
              ),
              Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
