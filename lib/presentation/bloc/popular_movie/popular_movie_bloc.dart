import 'dart:async';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';

part 'popular_movie_event.dart';

part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieEmpty()) {
    on<OnPopularMovie>(_onPopularMovie);
  }

  FutureOr<void> _onPopularMovie(
      OnPopularMovie event, Emitter<PopularMovieState> emit) async {
    final result = await _getPopularMovies.execute();

    result.fold((failure) {
      emit(PopularMovieError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(PopularMovieEmpty())
          : emit(PopularMovieHasData(success));
    });
  }
}
