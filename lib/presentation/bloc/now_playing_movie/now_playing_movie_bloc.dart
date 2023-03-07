import 'dart:async';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_movie_state.dart';

part 'now_playing_movie_event.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMovieBloc(
    this._getNowPlayingMovies,
  ) : super(NowPlayingMovieEmpty()) {
    on<OnNowPlayingMovie>(_onNowPlayingMovie);
  }

  FutureOr<void> _onNowPlayingMovie(
      OnNowPlayingMovie event, Emitter<NowPlayingMovieState> emit) async {
    emit(NowPlayingMovieLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold((failure) {
      emit(NowPlayingMovieError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(NowPlayingMovieEmpty())
          : emit(NowPlayingMovieHasData(success));
    });
  }
}
