import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/base_detail_notifier.dart';

class TvSeriesDetailNotifier
    extends BaseDetailNotifier<TvSeriesDetail, TvSeries> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListTvSeriesStatus getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  Future<void> fetchTvSeriesDetail(int id) async {
    await Future.wait([
      fetchMovieOrTvSeriesDetail(
        detailResult: getTvSeriesDetail.execute(id),
        recommendationResult: getTvSeriesRecommendations.execute(id),
      ),
      loadWatchlistStatus(getWatchListStatus.execute(id))
    ]);
  }

  Future<void> addWatchlistTvSeries(TvSeriesDetail tvSeries) async {
    await addWatchlist(
      saveWatchlist: saveWatchlist.execute(tvSeries),
      loadStatus: loadWatchlistStatus(getWatchListStatus.execute(tvSeries.id)),
    );
  }

  Future<void> removeFromWatchlistTvSeries(TvSeriesDetail tvSeries) async {
    await removeFromWatchlist(
      removeWatchlist: removeWatchlist.execute(tvSeries),
      loadStatus: loadWatchlistStatus(getWatchListStatus.execute(tvSeries.id)),
    );
  }
}
