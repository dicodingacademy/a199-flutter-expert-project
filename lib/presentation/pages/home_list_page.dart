import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/home_movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/home_tv_series_list_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/base_item_entity.dart';

class HomeListPage extends StatefulWidget {
  final ItemType itemType;
  static const ROUTE_NAME = '/home-list';

  const HomeListPage({Key? key, required this.itemType}) : super(key: key);

  @override
  _HomeListPageState createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => widget.itemType == ItemType.movie
        ? Provider.of<HomeMovieListNotifier>(context, listen: false)
            .fetchNowPlayingList()
        : Provider.of<HomeTvSeriesListNotifier>(context, listen: false)
            .fetchOnAirTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.itemType == ItemType.movie ? 'Now Playing Movies' : 'On Airing Tv Series',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.itemType == ItemType.movie
            ? Consumer<HomeMovieListNotifier>(
                builder: (context, data, child) {
                  if (data.homelistState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.homelistState == RequestState.Loaded) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = data.homeList[index];
                        return MovieCard(movie);
                      },
                      itemCount: data.homeList.length,
                    );
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              )
            : Consumer<HomeTvSeriesListNotifier>(
                builder: (context, data, child) {
                  if (data.homelistState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.homelistState == RequestState.Loaded) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final tvSeries = data.homeList[index];
                        return MovieCard(tvSeries);
                      },
                      itemCount: data.homeList.length,
                    );
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              ),
      ),
    );
  }
}
