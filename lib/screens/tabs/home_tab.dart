import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/home_provider.dart';
import 'package:onemovies/screens/components/latest_slider.dart';
import 'package:onemovies/screens/components/section_header.dart';
import 'package:onemovies/screens/components/single_banner.dart';
import 'package:onemovies/screens/components/spotlight_banner.dart';
import 'package:onemovies/screens/components/top_anime_slider.dart';
import 'package:onemovies/screens/components/trending_slider.dart';
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
                        text: "Trending",
                      ),
                      SizedBox(height: 10,),

                      TrendingSlider(trendings: homeResponse.trendings),

                      SizedBox(height: 20,),
                      SectionHeader(
                        onTap: () => print("tapped"),
                        text: "Latest Arrival",
                      ),
                      SizedBox(height: 10,),
                      LatestSlider(latestEpisode: homeResponse.latestEpisodes),

                      SizedBox(height: 20,),
                      TopAnimeSlider(text: "Top Today", onTap: () {}, topAnime: homeResponse.topAnime.today),

                       SizedBox(height: 20,),
                      TopAnimeSlider(text: "Top this Week", onTap: () {}, topAnime: homeResponse.topAnime.week),

                       SizedBox(height: 20,),
                      TopAnimeSlider(text: "Top this Month", onTap: () {}, topAnime: homeResponse.topAnime.month)
                      
                    ],
                  ),
                ),
                // you can continue with Trending, Latest, etc.
              ],
            ),
          );
        },
      ),
    );
  }
}
