import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([TvTopRatedCubit])
void main() {
  late MockTvTopRatedCubit mockNotifier;

  setUp(() {
    mockNotifier = MockTvTopRatedCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvTopRatedCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    final expected = TvTopRatedState.initial().copyWith(
      state: RequestState.Loading,
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    final expected = TvTopRatedState.initial().copyWith(
      state: RequestState.Loaded,
      tvs: <Tv>[testTv],
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(listViewFinder, findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    final expected = TvTopRatedState.initial().copyWith(
      state: RequestState.Error,
      message: 'Error message',
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
