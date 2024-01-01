import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:flutter/foundation.dart';

class BaseWatchlistNotifier<T extends BaseItemEntity> extends ChangeNotifier {
  var _watchlist = <T>[];
  List<T> get watchlist => _watchlist;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlist(Future<Either<Failure, List<T>>> execute) async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await execute;
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlist = moviesData;
        notifyListeners();
      },
    );
  }
}
