import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/presentation/provider/base_detail_notifier.dart';

class MovieDetailNotifier extends BaseDetailNotifier<MovieDetail, Movie> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListMovieStatus getWatchListStatus;
  final SaveWatchlistMovie saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  Future<void> fetchMovieDetail(int id) async {
    await Future.wait([
      fetchMovieOrTvSeriesDetail(
        detailResult: getMovieDetail.execute(id),
        recommendationResult: getMovieRecommendations.execute(id),
      ),
      loadWatchlistStatus(getWatchListStatus.execute(id))
    ]);
  }

  Future<void> addWatchlistMovies(MovieDetail movie) async {
    await addWatchlist(
      saveWatchlist: saveWatchlist.execute(movie),
      loadStatus: loadWatchlistStatus(getWatchListStatus.execute(movie.id)),
    );
  }

  Future<void> removeFromWatchlistMovies(MovieDetail movie) async {
    await removeFromWatchlist(
      removeWatchlist: removeWatchlist.execute(movie),
      loadStatus: loadWatchlistStatus(getWatchListStatus.execute(movie.id)),
    );
  }
}
