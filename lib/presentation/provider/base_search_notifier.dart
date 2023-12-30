import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:flutter/foundation.dart';

class BaseSearchNotifier<T extends BaseItemEntity> extends ChangeNotifier {
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<T> _searchResult = [];
  List<T> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieOrTvSeriesSearch(Future<Either<Failure, List<T>>> execute) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await execute;
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
