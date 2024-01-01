import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/base_watchlist_notifier.dart';

class WatchlistTvSeriesNotifier extends BaseWatchlistNotifier<TvSeries> {
  WatchlistTvSeriesNotifier({required this.getWatchlistTvSeries});

  final GetWatchlistTvSeries getWatchlistTvSeries;

  Future<void> fetchWatchlistTvSeries() async {
    await fetchWatchlist(getWatchlistTvSeries.execute());
  }
}
