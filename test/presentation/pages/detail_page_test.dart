import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier, TvSeriesDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockMovieDetailNotifier;
  late MockTvSeriesDetailNotifier mockTvSeriesDetailNotifier;

  setUp(() {
    mockMovieDetailNotifier = MockMovieDetailNotifier();
    mockTvSeriesDetailNotifier = MockTvSeriesDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      child: MaterialApp(
        home: body,
      ),
      providers: [
        ChangeNotifierProvider<MovieDetailNotifier>.value(
          value: mockMovieDetailNotifier,
        ),
        ChangeNotifierProvider<TvSeriesDetailNotifier>.value(
          value: mockTvSeriesDetailNotifier,
        ),
      ],
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailNotifier.state).thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.itemDetail).thenReturn(testMovieDetail);
    when(mockMovieDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.recommendations).thenReturn(<Movie>[]);
    when(mockMovieDetailNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
      _makeTestableWidget(
        DetailPage(
          baseItemEntity: testMovie,
        ),
      ),
    );

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when TV Series not added to watchlist',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.itemDetail).thenReturn(testTvSeriesDetail);
    when(mockTvSeriesDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.recommendations).thenReturn(<TvSeries>[]);
    when(mockTvSeriesDetailNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
      _makeTestableWidget(
        DetailPage(
          baseItemEntity: testTvSeries,
        ),
      ),
    );

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockMovieDetailNotifier.state).thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.itemDetail).thenReturn(testMovieDetail);
    when(mockMovieDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.recommendations).thenReturn(<Movie>[]);
    when(mockMovieDetailNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(
      _makeTestableWidget(
        DetailPage(baseItemEntity: testMovie),
      ),
    );

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when TV Series is added to wathclist',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.itemDetail).thenReturn(testTvSeriesDetail);
    when(mockTvSeriesDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.recommendations).thenReturn(<TvSeries>[]);
    when(mockTvSeriesDetailNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(
      _makeTestableWidget(
        DetailPage(baseItemEntity: testTvSeries),
      ),
    );

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to movie watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailNotifier.state).thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.itemDetail).thenReturn(testMovieDetail);
    when(mockMovieDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.recommendations).thenReturn(<Movie>[]);
    when(mockMovieDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockMovieDetailNotifier.watchlistMessage)
        .thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
      _makeTestableWidget(
        DetailPage(baseItemEntity: testMovie),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to TV Series watchlist',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.itemDetail).thenReturn(testTvSeriesDetail);
    when(mockTvSeriesDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.recommendations).thenReturn(<TvSeries>[]);
    when(mockTvSeriesDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTvSeriesDetailNotifier.watchlistMessage)
        .thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
      _makeTestableWidget(
        DetailPage(baseItemEntity: testTvSeries),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to Movie watchlist failed',
      (WidgetTester tester) async {
    when(mockMovieDetailNotifier.state).thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.itemDetail).thenReturn(testMovieDetail);
    when(mockMovieDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockMovieDetailNotifier.recommendations).thenReturn(<Movie>[]);
    when(mockMovieDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockMovieDetailNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
      _makeTestableWidget(
        DetailPage(baseItemEntity: testMovie),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to TV Series watchlist failed',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.itemDetail).thenReturn(testTvSeriesDetail);
    when(mockTvSeriesDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.recommendations).thenReturn(<TvSeries>[]);
    when(mockTvSeriesDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTvSeriesDetailNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
      _makeTestableWidget(
        DetailPage(baseItemEntity: testTvSeries),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Failed');

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
