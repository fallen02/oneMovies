import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/home_provider.dart';
import 'package:onemovies/screens/components/latest_slider.dart';
import 'package:onemovies/screens/components/section_header.dart';
import 'package:onemovies/screens/components/single_banner.dart';
import 'package:onemovies/screens/components/spotlight_banner.dart';
import 'package:onemovies/screens/components/trending_section.dart';


class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final homeAsync = ref.watch(homeProvider);

    return Scaffold(
      body: homeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (homeResponse) {
          return SingleChildScrollView(
            // padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔥 SPOTLIGHT AUTOPLAY CAROUSEL
                SpotlightBanner(
                  itemCount: homeResponse.spotlights.length,
                  itemBuilder: (context, index) {
                    final spotlight = homeResponse.spotlights[index];
                    return SingleBanner(spotlight: spotlight);
                  },
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Column(
                    children: [
                      SectionHeader(
                        onTap: () => print("tapped"),
                        text: "Latest Arrival",
                      ),
                      SizedBox(height: 10),
                      LatestSlider(latestEpisode: homeResponse.latest),

                      SizedBox(height: 20),
                      Column(
                        spacing: 20,
                        children: homeResponse.trendings
                            .map(
                              (trending) => TrendingSection(trending: trending),
                            )
                            .toList(),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
