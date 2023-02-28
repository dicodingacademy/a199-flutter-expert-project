import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:flutter/foundation.dart';

class PopularSeriesNotifier extends ChangeNotifier {
  final GetPopularSeries getPopularSeries;

  PopularSeriesNotifier(this.getPopularSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _series = [];
  List<Series> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (seriesData) {
        _series = seriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
