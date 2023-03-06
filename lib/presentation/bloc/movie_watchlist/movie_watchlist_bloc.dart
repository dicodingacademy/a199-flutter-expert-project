import 'dart:async';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_watchlist_state.dart';

part 'movie_watchlist_event.dart';

class MovieWatchListBloc
    extends Bloc<MovieWatchListEvent, MovieWatchListState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  MovieWatchListBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._removeWatchlist, this._saveWatchlist)
      : super(MovieWatchListInitial()) {
    on<OnFetchMovieWatchList>(_onFetchMovieWatchList);
    on<MovieWatchListStatus>(_onMovieWatchListStatus);
    on<MovieWatchListAdd>(_onMovieWatchListAdd);
    on<MovieWatchListRemove>(_onMovieWatchListRemove);
  }

  FutureOr<void> _onFetchMovieWatchList(
      OnFetchMovieWatchList event, Emitter<MovieWatchListState> emit) async {
    emit(MovieWatchListLoading());
    final result = await _getWatchlistMovies.execute();

    result.fold((failure) {
      emit(MovieWatchListError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MovieWatchListEmpty())
          : emit(MovieWatchListHasData(success));
    });
  }

  FutureOr<void> _onMovieWatchListStatus(
      MovieWatchListStatus event, Emitter<MovieWatchListState> emit) async {
    final id = event.id;
    final result = await _getWatchListStatus.execute(id);
    emit(MovieWatchListIsAdded(result));
  }

  FutureOr<void> _onMovieWatchListAdd(
      MovieWatchListAdd event, Emitter<MovieWatchListState> emit) async {
    final movie = event.movieDetail;

    final result = await _saveWatchlist.execute(movie);
    result.fold((failure) {
      emit(MovieWatchListError(failure.message));
    }, (success) {
      emit(MovieWatchListMessage(success));
    });
  }

  FutureOr<void> _onMovieWatchListRemove(
      MovieWatchListRemove event, Emitter<MovieWatchListState> emit) async {
    final movie = event.movieDetail;
    final result = await _removeWatchlist.execute(movie);
    result.fold((failure) {
      emit(MovieWatchListError(failure.message));
    }, (success) {
      emit(MovieWatchListMessage(success));
    });
  }
}
