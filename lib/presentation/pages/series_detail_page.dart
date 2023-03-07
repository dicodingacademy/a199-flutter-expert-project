import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/presentation/bloc/series_detail/series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series_recommendation/series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/series_watchlist/series_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/series/detail';

  final int id;
  SeriesDetailPage({required this.id});

  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeriesDetailBloc>().add(OnSeriesDetail(widget.id));
      context
          .read<SeriesRecommendationBloc>()
          .add(OnSeriesRecommendation(widget.id));
      context.read<SeriesWatchListBloc>().add(SeriesWatchListStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSeriesAddedToWatchList =
        context.select<SeriesWatchListBloc, bool>((bloc) {
      if (bloc.state is SeriesWatchListIsAdded) {
        return (bloc.state as SeriesWatchListIsAdded).isAdded;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
        builder: (context, state) {
          if (state is SeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeriesDetailHasData) {
            final series = state.result;
            return DetailContent(
                series: series, isAddedWatchlist: isSeriesAddedToWatchList);
          } else {
            return const Center(
              child: Text("Failed"),
            );
          }
        }
      )
    );
  }
}

class DetailContent extends StatefulWidget {
  final SeriesDetail series;
  bool isAddedWatchlist;

  DetailContent({super.key, required this.series, required this.isAddedWatchlist});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.series.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
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
                              widget.series.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context
                                    .read<SeriesWatchListBloc>()
                                    .add(SeriesWatchListAdd(widget.series));
                                } else {
                                  context
                                    .read<SeriesWatchListBloc>()
                                    .add(SeriesWatchListRemove(widget.series));
                                }
                                final state = BlocProvider.of<SeriesWatchListBloc>(context).state;
                                String message = '';

                                if (state is SeriesWatchListIsAdded) {
                                  final isAdded = state.isAdded;
                                  message = isAdded == false ? "Added to wishlist" : "Removed from wishlist";
                                } else {
                                  message = !widget.isAddedWatchlist ? "Added to wishlist" : "Removed from wishlist";
                                }
                                if (message == "Added to wishlist" || message == "Removed from wishlist") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                                setState(() {
                                  widget.isAddedWatchlist = !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.series.genres),
                            ),
                            Text(
                              widget.series.numberOfSeasons.toString() +
                                ' Seasons, ' +
                                widget.series.numberOfEpisodes.toString() +
                                ' Episodes',
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.series.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.series.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.series.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<SeriesRecommendationBloc, SeriesRecommendationState>(
                              builder: (context, state) {
                            if (state is SeriesRecommendationLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is SeriesRecommendationHasData) {
                              final movieRecommendation = state.result;
                              return Container(
                                margin: const EdgeInsets.only(top: 8),
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final recommendation = movieRecommendation[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, SeriesDetailPage.ROUTE_NAME,
                                              arguments: recommendation.id);
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.all(Radius.circular(8)),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "$BASE_IMAGE_URL${recommendation.posterPath}",
                                            placeholder: (context, url) => const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 12),
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget: (context, url, error) =>
                                                const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: movieRecommendation.length,
                                ),
                              );
                            } else if (state is SeriesRecommendationEmpty) {
                              return const Text("-");
                            } else {
                              return const Text("Failed");
                            }
                          }),
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

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
