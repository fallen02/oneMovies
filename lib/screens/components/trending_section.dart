import 'package:flutter/material.dart';
import 'package:onemovies/models/home.dart';
import 'package:onemovies/screens/components/section_header.dart';
import 'package:onemovies/screens/components/small_card.dart';

class TrendingSection extends StatelessWidget {
  final Trending trending;
  const TrendingSection({super.key, required this.trending});

  @override
  Widget build(BuildContext context) {
    final String headerTxt;
    switch(trending.type) {
      case 'trending':
        headerTxt = 'Trending Now';
        break;
      case 'day': 
        headerTxt = 'Trending Today';
        break;
      case 'week':
        headerTxt = 'Trending This Week';
        break;
      case 'month':
        headerTxt = "Trending This Month";
        break;
      default: 
        headerTxt = "Trendings";
        break;
    }

    return Column(
      spacing: 10,
      children: [
        SectionHeader(onTap: () {}, text: headerTxt),

        SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trending.data.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = trending.data[index];
          return Padding(
            padding: EdgeInsets.only(
              // left: index == 0 ? 10 : 0,
              right: 10,
            ),
            child: SmallCard(
              id: item.id,
              title: item.title,
              poster: item.poster,
              epiNo: item.sub.toString(),
              // runtime: item.runtime,
              type: item.type.name,

            ),
          );
        },
      ),
    )
      ],
    );
  }
}
