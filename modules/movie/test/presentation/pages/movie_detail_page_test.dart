import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailCubit])
void main() {
  late MockMovieDetailCubit mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Circullar progress should display when still loading',
      (WidgetTester tester) async {
    final expected = MovieDetailState.initial().copyWith(
      movieState: RequestState.Loading,
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final circularProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(circularProgress, findsOneWidget);
  });

  testWidgets('Message should display when error', (WidgetTester tester) async {
    final expected = MovieDetailState.initial().copyWith(
      movieState: RequestState.Error,
      message: "Error",
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final message = find.text("Error");

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(message, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    final expected = MovieDetailState.initial().copyWith(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: <Movie>[testMovie],
      isAddedToWatchlist: false,
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    final expected = MovieDetailState.initial().copyWith(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: <Movie>[testMovie],
      isAddedToWatchlist: true,
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    final expected = MovieDetailState.initial().copyWith(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: <Movie>[testMovie],
      isAddedToWatchlist: true,
      watchlistMessage: 'Added to Watchlist',
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    final expected = MovieDetailState.initial().copyWith(
      movieState: RequestState.Loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.Loaded,
      movieRecommendations: <Movie>[testMovie],
      isAddedToWatchlist: false,
      watchlistMessage: 'Failed',
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
