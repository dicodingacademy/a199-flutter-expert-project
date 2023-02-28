import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:flutter/foundation.dart';

class SeriesSearchNotifier extends ChangeNotifier {
  final SearchSeries searchSeries;

  SeriesSearchNotifier({required this.searchSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _searchResult = [];
  List<Series> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
