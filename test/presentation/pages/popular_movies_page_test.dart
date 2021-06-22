import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesNotifier])
void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    final mockNotifier = MockPopularMoviesNotifier();
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(
      ChangeNotifierProvider<PopularMoviesNotifier>.value(
        value: mockNotifier,
        child: _makeTestableWidget(PopularMoviesPage()),
      ),
    );

    expect(progressBarFinder, findsOneWidget);
  });
}
