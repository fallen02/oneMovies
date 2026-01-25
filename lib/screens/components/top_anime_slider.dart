import 'package:flutter/material.dart';
import 'package:onemovies/models/home.dart';
import 'package:onemovies/screens/components/section_header.dart';
import 'package:onemovies/screens/components/small_card.dart';

class TopAnimeSlider extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final List<Trending> topAnime;

  const TopAnimeSlider({
    super.key,
    required this.text,
    required this.onTap,
    required this.topAnime,
  });

  @override
  State<TopAnimeSlider> createState() => _TopAnimeSliderState();
}

class _TopAnimeSliderState extends State<TopAnimeSlider> {
  @override
  Widget build(BuildContext context) {
    final text = widget.text;
    final onTap = widget.onTap;

    return Column(
      children: [
        SectionHeader(onTap: onTap, text: text),
        SizedBox(height: 10,),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: widget.topAnime.length,
            itemBuilder: (context, index) {
              final item = widget.topAnime[index];
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
        ),
      ],
    );
  }
}
