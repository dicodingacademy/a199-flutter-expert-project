import 'package:core/common/state_enum.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tvs_page_test.mocks.dart';

@GenerateMocks([TvWatchlistCubit])
void main() {
  late MockTvWatchlistCubit mockCubit;

  setUp(() {
    mockCubit = MockTvWatchlistCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvWatchlistCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display loading', (tester) async {
    final expected = TvWatchlistState.initial().copyWith(
      watchlistState: RequestState.Loading,
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display list of watchlist', (tester) async {
    final expected = TvWatchlistState.initial().copyWith(
      watchlistState: RequestState.Loaded,
      watchlistTvs: [
        testTv,
        testTv,
      ],
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

    expect(find.byType(TvCard), findsNWidgets(2));
  });

  testWidgets('Should display error', (tester) async {
    final expected = TvWatchlistState.initial().copyWith(
      watchlistState: RequestState.Error,
      message: 'Error',
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvsPage()));

    expect(find.text('Error'), findsOneWidget);
  });
}
