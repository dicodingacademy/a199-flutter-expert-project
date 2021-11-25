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
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([MovieTopRatedCubit])
void main() {
  late MockMovieTopRatedCubit mockNotifier;

  setUp(() {
    mockNotifier = MockMovieTopRatedCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    final expected = MovieTopRatedState.initial().copyWith(
      state: RequestState.Loading,
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    final expected = MovieTopRatedState.initial().copyWith(
      state: RequestState.Loaded,
      movies: <Movie>[testMovie],
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    final expected = MovieTopRatedState.initial().copyWith(
      state: RequestState.Error,
      message: 'Error message',
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
