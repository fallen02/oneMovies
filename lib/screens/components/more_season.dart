import 'package:flutter/material.dart';
import 'package:onemovies/models/info.dart';
import 'package:onemovies/screens/components/small_card.dart';

class MoreSeasonSection extends StatelessWidget {
  final List<Relation> seasons;
  const MoreSeasonSection({super.key, required this.seasons});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "More Season",
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
                  poster: item.poster,

                ),
              );

            },
          ),
        )
      ],
    );
  }
}