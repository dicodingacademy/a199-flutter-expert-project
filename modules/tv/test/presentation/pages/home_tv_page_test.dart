import 'package:core/common/state_enum.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_tv_page_test.mocks.dart';

@GenerateMocks([TvListCubit])
void main() {
  late MockTvListCubit mockCubit;

  setUp(() {
    mockCubit = MockTvListCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvListCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Now Playing', () {
    testWidgets('Should display now playing loading', (tester) async {
      final expected = TvListState.initial().copyWith(
        nowPlayingState: RequestState.Loading,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should display now playing loaded', (tester) async {
      final expected = TvListState.initial().copyWith(
        nowPlayingState: RequestState.Loaded,
        nowPlayingTvs: [
          testTv,
          testTv,
        ],
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(find.byType(TvList), findsOneWidget);
    });

    testWidgets('Should display now playing error', (tester) async {
      final expected = TvListState.initial().copyWith(
        nowPlayingState: RequestState.Error,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(find.text('Failed'), findsWidgets);
    });
  });

  group('Popular', () {
    testWidgets('Should display popular loading', (tester) async {
      final expected = TvListState.initial().copyWith(
        popularTvsState: RequestState.Loading,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should display popular loaded', (tester) async {
      final expected = TvListState.initial().copyWith(
        popularTvsState: RequestState.Loaded,
        popularTvs: [
          testTv,
          testTv,
        ],
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(find.byType(TvList), findsOneWidget);
    });

    testWidgets('Should display popular error', (tester) async {
      final expected = TvListState.initial().copyWith(
        popularTvsState: RequestState.Error,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(find.text('Failed'), findsWidgets);
    });
  });

  group('Top Rated', () {
    testWidgets('Should display top rated loading', (tester) async {
      final expected = TvListState.initial().copyWith(
        topRatedTvsState: RequestState.Loading,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should display top rated loaded', (tester) async {
      final expected = TvListState.initial().copyWith(
        topRatedTvsState: RequestState.Loaded,
        topRatedTvs: [
          testTv,
          testTv,
        ],
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(find.byType(TvList), findsOneWidget);
    });

    testWidgets('Should display top rated error', (tester) async {
      final expected = TvListState.initial().copyWith(
        topRatedTvsState: RequestState.Error,
      );

      when(mockCubit.state).thenReturn(expected);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(find.text('Failed'), findsWidgets);
    });
  });
}
