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
import 'tv_search_page_test.mocks.dart';

@GenerateMocks([TvSearchCubit])
void main() {
  late MockTvSearchCubit mockCubit;

  setUp(() {
    mockCubit = MockTvSearchCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSearchCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display search bar', (tester) async {
    final expected = TvSearchState.initial();

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Should display loading', (tester) async {
    final expected = TvSearchState.initial().copyWith(
      state: RequestState.Loading,
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display search result', (tester) async {
    final expected = TvSearchState.initial().copyWith(
      state: RequestState.Loaded,
      searchResult: [
        testTv,
        testTv,
      ],
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));

    expect(find.byType(TvCard), findsNWidgets(2));
  });

  testWidgets('Should display nothing', (tester) async {
    final expected = TvSearchState.initial().copyWith(
      state: RequestState.Error,
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(TvSearchPage()));

    expect(find.byType(Container), findsOneWidget);
  });
}
