import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/episodes.dart';
import 'package:onemovies/providers/selected_anime_episode_provider.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class EpisodeList extends ConsumerStatefulWidget {
  final List<Episode> episodes;

  const EpisodeList({super.key, required this.episodes});

  @override
  ConsumerState<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends ConsumerState<EpisodeList> {
  static const int pageSize = 100;
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(selectedAnimeEpisodeProvider.notifier);
      if (widget.episodes.isNotEmpty) {
        notifier.state = widget.episodes.first;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedEpisode = ref.watch(selectedAnimeEpisodeProvider);

    if (widget.episodes.isEmpty) {
      return const Center(child: Text('No episodes available'));
    }

    final totalPages = (widget.episodes.length / pageSize).ceil();

    final start = selectedPage * pageSize;
    final end = (start + pageSize > widget.episodes.length)
        ? widget.episodes.length
        : start + pageSize;

    final visibleEpisodes = widget.episodes.sublist(start, end);

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Column(
        spacing: 10,
        children: [
          // 🔽 Dropdown only if episodes > 100
          if (totalPages > 1)
            Row(
              spacing: 10,
              children: [
                Text('Episodes:', style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20),),
                DropdownButtonHideUnderline(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 0,
                    ),
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //   color: Theme.of(
                      //     context,
                      //   ).colorScheme.outline.withOpacity(0.4),
                      // ),
                    ),
                    child: DropdownButton<int>(
                      value: selectedPage,
                      icon: Icon(
                        Broken.arrow_down_2,
                        size: 18,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(12),
                      style: Theme.of(context).textTheme.bodyMedium,
                      items: List.generate(totalPages, (index) {
                        final rangeStart = index * pageSize + 1;
                        final rangeEnd =
                            ((index + 1) * pageSize > widget.episodes.length)
                            ? widget.episodes.length
                            : (index + 1) * pageSize;

                        return DropdownMenuItem<int>(
                          value: index,
                          child: Padding(padding: EdgeInsetsGeometry.all(0), child: Text(
                            '$rangeStart–$rangeEnd',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),)
                        );
                      }),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedPage = value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),

          // 🧱 Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: visibleEpisodes.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 40,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final episode = visibleEpisodes[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    ref.read(selectedAnimeEpisodeProvider.notifier).state = episode;
                    
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: episode.isFiller
                          ? Colors.deepOrangeAccent
                          : Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(5),
                      border: BoxBorder.all(
                        width: 1,
                        color: selectedEpisode?.id == episode.id
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    child: Text(
                      episode.number.toString(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold, fontFamily: 'Ubuntu'
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
