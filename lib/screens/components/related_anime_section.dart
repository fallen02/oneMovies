import 'package:flutter/material.dart';
import 'package:onemovies/models/info.dart';
import 'package:onemovies/screens/components/small_card.dart';

class RelatedAnimeSection extends StatelessWidget {
  final String headingTxt;
  final List<Recommendation> seasons;
  const RelatedAnimeSection({super.key, required this.seasons, required this.headingTxt});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headingTxt,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: colors.onSurface,
            fontFamily: 'Ubuntu',
            fontSize: 20,
          ),
        ),

        SizedBox(height: 10,),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: seasons.length,
            itemBuilder: (context, index) {
              final item = seasons[index];

              return Padding(
                padding: EdgeInsets.only(
                  // left: index == 0 ? 10 : 0,
                  right: 10,
                ),
                child: SmallCard(
                  id: item.id,
                  title: item.title,
                  poster: item.image,
                  epiNo: item.sub.toString(),
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