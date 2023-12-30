import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';

class BasePopularNotifier<BaseItemEntity> extends ChangeNotifier {
  var _list = <BaseItemEntity>[];
  List<BaseItemEntity> get popularList => _list;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> onPopularMovieOrTvSeries({
    required Future<Either<Failure, List<BaseItemEntity>>> result,
  }) async {
    _state = RequestState.Loading;
    notifyListeners();

    final getResult = await result;
    getResult.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _state = RequestState.Loaded;
        _list = moviesData;
        notifyListeners();
      },
    );
  }

}