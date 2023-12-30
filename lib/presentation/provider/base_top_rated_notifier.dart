import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/foundation.dart';

class BaseTopRatedNotifier<BaseItemEntity> extends ChangeNotifier {
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<BaseItemEntity> _list = [];
  List<BaseItemEntity> get baseTopRatedList => _list;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMoviesOrTvSeries({
    required Future<Either<Failure, List<BaseItemEntity>>> result,
  }) async {
    _state = RequestState.Loading;
    notifyListeners();

    final getResult = await result;

    getResult.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (listData) {
        _list = listData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
