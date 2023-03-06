import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_event.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';

part 'search_movie_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovie;

  SearchMovieBloc(this._searchMovie) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      print(query);

      emit(SearchLoading());
      final result = await _searchMovie.execute(query);
      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (success) {
        emit(SearchHasData(success));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
