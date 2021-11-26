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
import 'popular_tv_page_test.mocks.dart';

@GenerateMocks([TvPopularCubit])
void main() {
  late MockTvPopularCubit mockCubit;

  setUp(() {
    mockCubit = MockTvPopularCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvPopularCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    final expected = TvPopularState.initial().copyWith(
      state: RequestState.Loading,
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    final expected = TvPopularState.initial().copyWith(
      state: RequestState.Loaded,
      tvs: <Tv>[testTv],
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(listViewFinder, findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    final expected = TvPopularState.initial().copyWith(
      state: RequestState.Error,
      message: 'Error message',
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
