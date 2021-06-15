import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:flutter/foundation.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;

  MovieSearchNotifier(this.searchMovies);
}
