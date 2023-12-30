import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/provider/base_popular_notifier.dart';

class PopularTvSeriesNotifier extends BasePopularNotifier<TvSeries> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesNotifier(this.getPopularTvSeries);

  Future<void> fetchPopularTvSeries() async {
    await onPopularMovieOrTvSeries(
      result: getPopularTvSeries.execute(),
    );
  }
}
