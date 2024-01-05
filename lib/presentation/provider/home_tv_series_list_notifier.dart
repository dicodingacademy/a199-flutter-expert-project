import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_on_air_tv_series.dart';
import 'package:ditonton/presentation/provider/base_home_list_notifier.dart';

class HomeTvSeriesListNotifier extends BaseHomeListNotifier<TvSeries> {
  final GetOnAirTvSeries getOnAirTvSeries;
  HomeTvSeriesListNotifier(this.getOnAirTvSeries);

  Future<void> fetchOnAirTvSeries() async {
    await getCurrenlyOnAirOrNowPlaying(
      getOnAirTvSeries.execute(),
    );
  }
}
