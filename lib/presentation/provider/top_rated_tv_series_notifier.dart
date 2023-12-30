import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/base_top_rated_notifier.dart';

class TopRatedTvSeriesNotifier extends BaseTopRatedNotifier<TvSeries> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesNotifier({required this.getTopRatedTvSeries});

  Future<void> fetchTopRatedTvSeries() async {
    await fetchTopRatedMoviesOrTvSeries(
      result: getTopRatedTvSeries.execute(),
    );
  }
}
