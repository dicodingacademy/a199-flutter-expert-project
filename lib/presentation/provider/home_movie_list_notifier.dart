import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/provider/base_home_list_notifier.dart';

class HomeMovieListNotifier extends BaseHomeListNotifier<Movie> {
  final GetNowPlayingMovies getNowPlayingMovies;
  HomeMovieListNotifier(this.getNowPlayingMovies);

  Future<void> fetchNowPlayingList() async {
    await getCurrenlyOnAirOrNowPlaying(
      getNowPlayingMovies.execute(),
    );
  }
}
