import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:flutter/foundation.dart';

class PopularMoviesNotifier extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  PopularMoviesNotifier(this.getPopularMovies);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  Future<void> fetchPopularMovies() async {
    _state = RequestState.Loading;
    notifyListeners();
  }
}
