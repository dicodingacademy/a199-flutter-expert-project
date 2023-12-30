import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/provider/base_search_notifier.dart';

class TvSeriesSearchNotifier extends BaseSearchNotifier<TvSeries> {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchNotifier({required this.searchTvSeries});

  Future<void> fetchTvSeriesSearch(String query) async {
    await fetchMovieOrTvSeriesSearch(
      searchTvSeries.execute(query),
    );
  }
}
