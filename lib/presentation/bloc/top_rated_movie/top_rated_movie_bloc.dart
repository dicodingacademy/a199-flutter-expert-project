import 'dart:async';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movie_state.dart';

part 'top_rated_movie_event.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<OnTopRatedMovie>(_onTopRatedMovie);
  }

  FutureOr<void> _onTopRatedMovie(
      OnTopRatedMovie event, Emitter<TopRatedMovieState> emit) async {
    emit(TopRatedMovieLoading());

    final result = await _getTopRatedMovies.execute();

    result.fold((failure) {
      emit(TopRatedMovieError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TopRatedMovieEmpty())
          : emit(TopRatedMovieHasData(success));
    });
  }
}
