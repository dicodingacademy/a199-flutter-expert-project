import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/bloc/series_watchlist/series_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/common/constants.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MovieWatchListBloc>().add(OnFetchMovieWatchList()));
    Future.microtask(
        () => context.read<SeriesWatchListBloc>().add(OnFetchSeriesWatchList()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(
        () => context.read<MovieWatchListBloc>().add(OnFetchMovieWatchList()));
    Future.microtask(
        () => context.read<SeriesWatchListBloc>().add(OnFetchSeriesWatchList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Movies',
                style: kHeading6,
              ),
              BlocBuilder<MovieWatchListBloc, MovieWatchListState>(
                builder: (context, state) {
              if (state is MovieWatchListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieWatchListHasData) {
                final data = state.result;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final movie = data[index];
                    return MovieCard(movie);
                  },
                );
              } else if (state is MovieWatchListEmpty) {
                return const Center(
                  child: Text("Watchlist Empty"),
                );
              } else {
                return const Center(
                  key: Key("error_message"),
                  child: Text("Failed"),
                );
              }
            }),
              SizedBox(
                height: 16,
              ),
              Text(
                'TV Series',
                style: kHeading6,
              ),
              BlocBuilder<SeriesWatchListBloc, SeriesWatchListState>(
                builder: (context, state) {
              if (state is SeriesWatchListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SeriesWatchListHasData) {
                final data = state.result;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final series = data[index];
                    return SeriesCard(series);
                  },
                );
              } else if (state is SeriesWatchListEmpty) {
                return const Center(
                  child: Text("Watchlist Empty"),
                );
              } else {
                return const Center(
                  key: Key("error_message"),
                  child: Text("Failed"),
                );
              }
            }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
