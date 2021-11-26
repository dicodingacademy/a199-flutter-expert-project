import 'package:core/common/state_enum.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_search_page_test.mocks.dart';

@GenerateMocks([MovieSearchCubit])
void main() {
  late MockMovieSearchCubit mockCubit;

  setUp(() {
    mockCubit = MockMovieSearchCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieSearchCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display search bar', (tester) async {
    final expected = MovieSearchState.initial();

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(MovieSearchPage()));

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Should display loading', (tester) async {
    final expected = MovieSearchState.initial().copyWith(
      state: RequestState.Loading,
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(MovieSearchPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display search result', (tester) async {
    final expected = MovieSearchState.initial().copyWith(
      state: RequestState.Loaded,
      searchResult: [
        testMovie,
        testMovie,
      ],
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(MovieSearchPage()));

    expect(find.byType(MovieCard), findsNWidgets(2));
  });

  testWidgets('Should display nothing', (tester) async {
    final expected = MovieSearchState.initial().copyWith(
      state: RequestState.Error,
    );

    when(mockCubit.state).thenReturn(expected);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(MovieSearchPage()));

    expect(find.byType(Container), findsOneWidget);
  });
}
