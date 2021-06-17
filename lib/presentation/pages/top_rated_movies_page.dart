import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatelessWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: ChangeNotifierProvider<TopRatedMoviesNotifier>(
        create: (context) =>
            TopRatedMoviesNotifier(locator())..fetchTopRatedMovies(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TopRatedMoviesNotifier>(
            builder: (context, data, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return MovieCard(movie);
                },
                itemCount: data.movies.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
