import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([MoviePopularCubit])
void main() {
  late MockMoviePopularCubit mockCubit;

  setUp(() {
    mockCubit = MockMoviePopularCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    final expected = MoviePopularState.initial().copyWith(
      state: RequestState.Loading,
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    final expected = MoviePopularState.initial().copyWith(
      state: RequestState.Loaded,
      movies: <Movie>[testMovie],
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    final expected = MoviePopularState.initial().copyWith(
      state: RequestState.Error,
      message: 'Error message',
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
