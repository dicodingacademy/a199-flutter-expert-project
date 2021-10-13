import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/episode.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  EpisodeCard(this.episode);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        image: episode.stillPath != null
            ? DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                ),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop),
                fit: BoxFit.cover,
              )
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              episode.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: kHeading6,
            ),
            Row(
              children: [
                RatingBarIndicator(
                  rating: episode.voteAverage != null
                      ? episode.voteAverage! / 2
                      : 0,
                  itemCount: 5,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: kMikadoYellow,
                  ),
                  itemSize: 14,
                ),
                Text('${episode.voteAverage}')
              ],
            ),
            SizedBox(height: 16),
            Text(
              episode.overview,
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Chip(
              backgroundColor: kPrussianBlue,
              label: Text(
                "Episode ${episode.episodeNumber}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kSubtitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
