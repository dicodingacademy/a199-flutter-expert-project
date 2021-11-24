import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/tv.dart';
import 'package:tv/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeasonDetailPage extends StatefulWidget {
  final int id;
  final int seasonNumber;

  TvSeasonDetailPage({
    required this.id,
    required this.seasonNumber,
  });

  @override
  State<TvSeasonDetailPage> createState() => _TvSeasonDetailPageState();
}

class _TvSeasonDetailPageState extends State<TvSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvSeasonDetailCubit>(context, listen: false)
          .fetchTvSeasonDetail(widget.id, widget.seasonNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TvSeasonDetailCubit, TvSeasonDetailState>(
          builder: (context, data) {
            switch (data.state) {
              case RequestState.Empty:
                return Text(data.message);
              case RequestState.Loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.Loaded:
                return SeasonEpisodes(seasonDetail: data.seasonDetail!);
              case RequestState.Error:
                return Text(data.message);
            }
          },
        ),
      ),
    );
  }
}

class SeasonEpisodes extends StatelessWidget {
  const SeasonEpisodes({
    Key? key,
    required this.seasonDetail,
  }) : super(key: key);

  final SeasonDetail seasonDetail;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        if (seasonDetail.posterPath != null)
          CachedNetworkImage(
            imageUrl:
                'https://image.tmdb.org/t/p/w500${seasonDetail.posterPath}',
            width: screenWidth,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        else
          Center(child: Icon(Icons.error)),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seasonDetail.name,
                              style: kHeading5,
                            ),
                            SizedBox(height: 16),
                            ListView.builder(
                              itemCount: seasonDetail.episodes.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final episode = seasonDetail.episodes[index];

                                return EpisodeCard(episode);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
