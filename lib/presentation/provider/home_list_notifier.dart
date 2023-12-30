import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:flutter/material.dart';

class HomeListNotifier<T extends BaseItemEntity> extends ChangeNotifier {
  var _onAirTList = <T>[];
  List<T> get nowPlayingTs => _onAirTList;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTList = <T>[];
  List<T> get popularTs => _popularTList;

  RequestState _popularTsState = RequestState.Empty;
  RequestState get popularTsState => _popularTsState;

  var _topRatedTList = <T>[];
  List<T> get topRatedTs => _topRatedTList;

  RequestState _topRatedTsState = RequestState.Empty;
  RequestState get topRatedTsState => _topRatedTsState;

  String _message = '';
  String get message => _message;

  void reset() {
    _onAirTList = [];
    _nowPlayingState = RequestState.Empty;

    _popularTList = [];
    _popularTsState = RequestState.Empty;

    _topRatedTList = [];
    _topRatedTsState = RequestState.Empty;
    notifyListeners();
  }

  Future<void> onPlayingMovieOrTvSeries({
    required Future<Either<Failure, List<T>>> result,
  }) async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final getResult = await result;
    getResult.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _onAirTList = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> onPopularMovieOrTvSeries({
    required Future<Either<Failure, List<T>>> result,
  }) async {
    _popularTsState = RequestState.Loading;
    notifyListeners();

    final getResult = await result;
    getResult.fold(
      (failure) {
        _popularTsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularTsState = RequestState.Loaded;
        _popularTList = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> onTopRatedMovieOrTvSeries({
    required Future<Either<Failure, List<T>>> result,
  }) async {
    _topRatedTsState = RequestState.Loading;
    notifyListeners();

    final getResult = await result;
    getResult.fold(
      (failure) {
        _topRatedTsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedTsState = RequestState.Loaded;
        _topRatedTList = moviesData;
        notifyListeners();
      },
    );
  }
}
