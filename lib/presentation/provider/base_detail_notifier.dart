import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaseDetailNotifier<BaseItemDetail, BaseItemEntitiy> extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late BaseItemDetail _detail;
  BaseItemDetail get itemDetail => _detail;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<BaseItemEntitiy> _recommendations = [];
  List<BaseItemEntitiy> get recommendations => _recommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchMovieOrTvSeriesDetail({required Future<Either<Failure, BaseItemDetail>> detailResult,required Future<Either<Failure, List<BaseItemEntitiy>>> recommendationResult}) async {
    _state = RequestState.Loading;
    notifyListeners();
    final varDetailResult = await detailResult;
    final varRecommendationResult = await recommendationResult;
    varDetailResult.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _recommendationState = RequestState.Loading;
        _detail = movie;
        notifyListeners();
        varRecommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.Loaded;
            _recommendations = movies;
          },
        );
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist({required Future<Either<Failure, String>> saveWatchlist,required Future<void> loadStatus}) async {
    final result = await saveWatchlist;

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadStatus;
  }

  Future<void> removeFromWatchlist({required Future<Either<Failure, String>> removeWatchlist,required Future<void> loadStatus}) async {
    final result = await removeWatchlist;

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadStatus;
  }

  Future<void> loadWatchlistStatus(Future<bool> getWatchListStatus) async {
    final getStatus = await getWatchListStatus;
    _isAddedtoWatchlist = getStatus;
    notifyListeners();
  }
}
