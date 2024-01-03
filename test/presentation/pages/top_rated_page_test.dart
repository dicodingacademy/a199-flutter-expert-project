import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesNotifier, TopRatedTvSeriesNotifier])
void main() {
  late MockTopRatedMoviesNotifier mockTopRatedMovieNotifier;
  late MockTopRatedTvSeriesNotifier mockTopRatedTvSeriesNotifier;


  setUp(() {
    mockTopRatedMovieNotifier = MockTopRatedMoviesNotifier();
    mockTopRatedTvSeriesNotifier = MockTopRatedTvSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      child: MaterialApp(
        home: body,
      ),
      providers: [
        ChangeNotifierProvider<TopRatedMoviesNotifier>.value(
          value: mockTopRatedMovieNotifier,
        ),
        ChangeNotifierProvider<TopRatedTvSeriesNotifier>.value(
          value: mockTopRatedTvSeriesNotifier,
        ),
      ],
    );
  }

  testWidgets('Page type movie should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedMovieNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedListPage(itemType: ItemType.movie,)));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });


  testWidgets('Page type tv series should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedTvSeriesNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedListPage(itemType: ItemType.tvSeries,)));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page type movie should display when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedMovieNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTopRatedMovieNotifier.baseTopRatedList).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedListPage(itemType: ItemType.movie,)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page type tv series should display when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedTvSeriesNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTopRatedTvSeriesNotifier.baseTopRatedList).thenReturn(<TvSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedListPage(itemType: ItemType.tvSeries,)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page type movie should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTopRatedMovieNotifier.state).thenReturn(RequestState.Error);
    when(mockTopRatedMovieNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedListPage(
      itemType: ItemType.movie
    )));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page type tv series should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTopRatedTvSeriesNotifier.state).thenReturn(RequestState.Error);
    when(mockTopRatedTvSeriesNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedListPage(
      itemType: ItemType.tvSeries
    )));

    expect(textFinder, findsOneWidget);
  });
}
