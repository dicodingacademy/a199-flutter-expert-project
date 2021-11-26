import 'package:core/common/state_enum.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_movie_page_test.mocks.dart';

@GenerateMocks([MovieListCubit])
void main() {
  late MockMovieListCubit mockCubit;

  setUp(() {
    mockCubit = MockMovieListCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieListCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Now Playing', () {
    testWidgets('Should display now playing loading', (tester) async {
      final expected = MovieListState.initial().copyWith(
        nowPlayingState: RequestState.Loading,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should display now playing loaded', (tester) async {
      final expected = MovieListState.initial().copyWith(
        nowPlayingState: RequestState.Loaded,
        nowPlayingMovies: [
          testMovie,
          testMovie,
        ],
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(find.byType(MovieList), findsOneWidget);
    });

    testWidgets('Should display now playing error', (tester) async {
      final expected = MovieListState.initial().copyWith(
        nowPlayingState: RequestState.Error,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(find.text('Failed'), findsWidgets);
    });
  });

  group('Popular', () {
    testWidgets('Should display popular loading', (tester) async {
      final expected = MovieListState.initial().copyWith(
        popularMoviesState: RequestState.Loading,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should display popular loaded', (tester) async {
      final expected = MovieListState.initial().copyWith(
        popularMoviesState: RequestState.Loaded,
        popularMovies: [
          testMovie,
          testMovie,
        ],
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(find.byType(MovieList), findsOneWidget);
    });

    testWidgets('Should display popular error', (tester) async {
      final expected = MovieListState.initial().copyWith(
        popularMoviesState: RequestState.Error,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(find.text('Failed'), findsWidgets);
    });
  });

  group('Top Rated', () {
    testWidgets('Should display top rated loading', (tester) async {
      final expected = MovieListState.initial().copyWith(
        topRatedMoviesState: RequestState.Loading,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should display top rated loaded', (tester) async {
      final expected = MovieListState.initial().copyWith(
        topRatedMoviesState: RequestState.Loaded,
        topRatedMovies: [
          testMovie,
          testMovie,
        ],
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(find.byType(MovieList), findsOneWidget);
    });

    testWidgets('Should display top rated error', (tester) async {
      final expected = MovieListState.initial().copyWith(
        topRatedMoviesState: RequestState.Error,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(find.text('Failed'), findsWidgets);
    });
  });
}
