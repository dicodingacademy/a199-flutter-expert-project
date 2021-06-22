import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatelessWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: ChangeNotifierProvider<PopularMoviesNotifier>(
        create: (context) =>
            PopularMoviesNotifier(locator())..fetchPopularMovies(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PopularMoviesNotifier>(
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
