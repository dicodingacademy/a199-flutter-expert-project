import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/home_list_page.dart';
import 'package:ditonton/presentation/provider/home_movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/home_tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'home_list_page_test.mocks.dart';

@GenerateMocks([HomeMovieListNotifier, HomeTvSeriesListNotifier])
void main() {
  late MockHomeMovieListNotifier mockHomeMovieListNotifier;
  late MockHomeTvSeriesListNotifier mockHomeTvSeriesListNotifier;

  setUp(() {
    mockHomeMovieListNotifier = MockHomeMovieListNotifier();
    mockHomeTvSeriesListNotifier = MockHomeTvSeriesListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      child: MaterialApp(
        home: body,
      ),
      providers: [
        ChangeNotifierProvider<HomeMovieListNotifier>.value(
          value: mockHomeMovieListNotifier,
        ),
        ChangeNotifierProvider<HomeTvSeriesListNotifier>.value(
          value: mockHomeTvSeriesListNotifier,
        ),
      ],
    );
  }

  testWidgets('Page type movie should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockHomeMovieListNotifier.homelistState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeListPage(
          itemType: ItemType.movie,
        ),
      ),
    );

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page type tv series should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockHomeTvSeriesListNotifier.homelistState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeListPage(
          itemType: ItemType.tvSeries,
        ),
      ),
    );

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page type movie should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockHomeMovieListNotifier.homelistState).thenReturn(RequestState.Loaded);
    when(mockHomeMovieListNotifier.homeList).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeListPage(
          itemType: ItemType.movie,
        ),
      ),
    );

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page type tv series should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockHomeTvSeriesListNotifier.homelistState).thenReturn(RequestState.Loaded);
    when(mockHomeTvSeriesListNotifier.homeList).thenReturn(<TvSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeListPage(
          itemType: ItemType.tvSeries,
        ),
      ),
    );

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page type movie should display text with message when Error',
      (WidgetTester tester) async {
    when(mockHomeMovieListNotifier.homelistState).thenReturn(RequestState.Error);
    when(mockHomeMovieListNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeListPage(
          itemType: ItemType.movie,
        ),
      ),
    );

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page type tv series should display text with message when Error',
      (WidgetTester tester) async {
    when(mockHomeTvSeriesListNotifier.homelistState).thenReturn(RequestState.Error);
    when(mockHomeTvSeriesListNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeListPage(
          itemType: ItemType.tvSeries,
        ),
      ),
    );

    expect(textFinder, findsOneWidget);
  });
}
