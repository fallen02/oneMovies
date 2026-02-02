import 'package:flutter/material.dart';
import 'package:onemovies/models/search.dart';
import 'package:onemovies/screens/anime_info.dart';
import 'package:onemovies/screens/components/custom_badge.dart';

import 'package:onemovies/screens/components/tick_eps.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class SearchCard extends StatelessWidget {
  final SearchResponse result;
  const SearchCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AnimeInfoScreen()),
        ),
      },
      child: ClipRRect(
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            // spacing: 10,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                child: Stack(
                  children: [
                    Image.network(result.image, fit: BoxFit.cover, width: 150),

                    if (result.nsfw)
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(6),
                            border: BoxBorder.all(color: colors.primary),
                          ),
                          child: Text(
                            "18+",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: colors.onSurface,
                            ),
                          ),
                        ),
                      ),

                    Positioned.fill(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Broken.play,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 0,
                    right: 5,
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    // color: colors.primary
                    border: BoxBorder.fromLTRB(
                      top: BorderSide(
                        width: 1,
                        color: colors.primary.withValues(alpha: 0.8),
                      ),
                      right: BorderSide(
                        width: 1,
                        color: colors.primary.withValues(alpha: 0.8),
                      ),
                      bottom: BorderSide(
                        width: 1,
                        color: colors.primary.withValues(alpha: 0.8),
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        result.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TickEps(
                            sub: result.sub,
                            dub: result.dub,
                            eps: result.episodes,
                          ),
                          CustomBadge(text: result.type.name),
                          if (result.duration != null &&
                              result.duration!.isNotEmpty)
                            CustomBadge(
                              text: result.duration!.toUpperCase(),
                              type: BadgeType.secondary,
                            ),
                        ],
                      ),

                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          BtnExtra(
                            icon: Broken.play,
                            onTap: () {},
                            text: "Watch Now",
                            background: colors.primary,
                            txtColor: Colors.white.withValues(alpha: 0.9),
                          ),
                          BtnExtra(
                            icon: Broken.more,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AnimeInfoScreen(),
                                ),
                              );
                            },
                            text: "View",
                            background: Colors.white,
                            txtColor: colors.primary.withValues(alpha: 0.8),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BtnExtra extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;
  final Color background;
  final Color txtColor;

  const BtnExtra({
    super.key,
    required this.icon,
    required this.onTap,
    required this.text,
    required this.background,
    required this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: background,
        minimumSize: const Size(7, 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: txtColor),
          SizedBox(width: 3),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w600,
              color: txtColor,
            ),
          ),
        ],
      ),
    );
  }
}
