import 'package:flutter/material.dart';
import 'package:onemovies/models/home.dart';
import 'package:onemovies/screens/components/small_card.dart';

class TrendingSlider extends StatefulWidget {
  final List<Trending> trendings;
  const TrendingSlider({super.key, required this.trendings});

  @override
  State<TrendingSlider> createState() => _TrendingSliderState();
}

class _TrendingSliderState extends State<TrendingSlider> {
  @override
  Widget build(BuildContext context) {
    final trendings = widget.trendings;
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: trendings.length,
        itemBuilder: (context, index) {
          final item = trendings[index];
          return Padding(
            padding: EdgeInsets.only(
              // left: index == 0 ? 10 : 0,
              right: 10,
            ),
            child: SmallCard(
              id: item.id,
              title: item.title,
              poster: item.poster,
            ),
          );
        },
      ),
    );
  }
}
