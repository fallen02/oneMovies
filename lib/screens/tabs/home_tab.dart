import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/home_provider.dart';
import 'package:onemovies/screens/tabs/components/single_banner.dart';
import 'package:onemovies/screens/tabs/components/spotlight_banner.dart';

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
        data: (home) {
          return SingleChildScrollView(
            // padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔥 SPOTLIGHT AUTOPLAY CAROUSEL
                SpotlightBanner(
                  itemCount: home.spotlights.length,
                  itemBuilder: (context, index) {
                    final spotlight = home.spotlights[index];
                    return SingleBanner(spotlight: spotlight);
                  },
                ),

                const SizedBox(height: 20),

                // you can continue with Trending, Latest, etc.
              ],
            ),
          );
        },
      ),
    );
  }
}
