import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<TopRatedMoviesNotifier>(returnNullOnMissingStub: true)
])
void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    final mockNotifier = MockTopRatedMoviesNotifier();
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(
      ChangeNotifierProvider<TopRatedMoviesNotifier>.value(
        value: mockNotifier,
        child: _makeTestableWidget(TopRatedMoviesPage()),
      ),
    );

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    final mockNotifier = MockTopRatedMoviesNotifier();
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      ChangeNotifierProvider<TopRatedMoviesNotifier>.value(
        value: mockNotifier,
        child: _makeTestableWidget(TopRatedMoviesPage()),
      ),
    );

    expect(listViewFinder, findsOneWidget);
  });
}
