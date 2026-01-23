import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/schedule_provider.dart';
import 'package:onemovies/screens/tabs/components/clock.dart';
import 'package:onemovies/screens/tabs/components/schedule_tile.dart';

class ScheduleTab extends ConsumerWidget {
  const ScheduleTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(scheduleProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: scheduleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (scheduleResponse) {
          final schedules = scheduleResponse.results;

          return RefreshIndicator(
            onRefresh: () async {
              ref.refresh(scheduleProvider);
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                //STICKY HEADER
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  elevation: 10,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
                  toolbarHeight: 60,
                  titleSpacing: 0,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(1),
                    child: Divider(height: 1, color: colors.surface),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Image(
                              image: AssetImage('assets/icons/icon.png'),
                              width: 45,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Schedule",
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: colors.primary,
                              ),
                            ),
                          ],
                        ),
                        const Clock(),
                      ],
                    ),
                  ),
                ),

                // LIST CONTENT
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = schedules[index];
                    return ScheduleTile(
                      id: item.id,
                      title: item.title,
                      japaneseTitle: item.japaneseTitle,
                      airingEpisode: item.airingEpisode,
                      airingTime: item.airingTime,
                    );
                  }, childCount: schedules.length),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
