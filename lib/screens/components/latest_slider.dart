import 'package:flutter/material.dart';
import 'package:onemovies/models/home.dart';
import 'package:onemovies/screens/components/small_card.dart';

class LatestSlider extends StatefulWidget {
  final List<LatestEpisode> latestEpisode;
  const LatestSlider({super.key, required this.latestEpisode});

  @override
  State<LatestSlider> createState() => _LatestSliderState();
}

class _LatestSliderState extends State<LatestSlider> {
  @override
  Widget build(BuildContext context) {
    final latestEpisode = widget.latestEpisode;
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: latestEpisode.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = latestEpisode[index];
          return Padding(
            padding: EdgeInsets.only(
              // left: index == 0 ? 10 : 0,
              right: 10,
            ),
            child: SmallCard(
              id: item.id,
              title: item.title,
              poster: item.poster,
              epiNo: item.episodeNo,
              runtime: item.runtime,
              type: item.type.name,
            ),
          );
        },
      ),
    );
  }
}
