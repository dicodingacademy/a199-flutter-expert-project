import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/season_detail_model.dart';
import 'package:tv/presentation/cubit/season_detail/tv_season_detail_cubit.dart';
import 'package:tv/presentation/pages/tv_season_detail_page.dart';
import 'package:tv/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_season_detail_page_test.mocks.dart';

@GenerateMocks([TvSeasonDetailCubit])
void main() {
  late MockTvSeasonDetailCubit mockNotifier;

  const tvId = 1;
  const seasonNumber = 1;

  final tEpisodeModel = EpisodeModel(
    airDate: '2011-04-17',
    episodeNumber: 1,
    id: 1,
    name: 'Winter Is Coming',
    overview:
        'Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon\'s place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.',
    seasonNumber: seasonNumber,
    stillPath: '/bxVxZiskqu5S8ypuO6jL9JrVLuz.jpg',
    productionCode: '',
    voteAverage: 9.1,
    voteCount: 1803,
  );

  final tSeasonDetail = SeasonDetailModel(
    airDate: '2011-04-17',
    episodes: [tEpisodeModel],
    id: 1,
    name: 'Season 1',
    overview: '',
    posterPath: '/bxVxZiskqu5S8ypuO6jL9JrVLuz.jpg',
    seasonNumber: seasonNumber,
  );

  setUp(() {
    mockNotifier = MockTvSeasonDetailCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeasonDetailCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display detail', (tester) async {
    final expected = TvSeasonDetailState.initial().copyWith(
      state: RequestState.Loaded,
      seasonDetail: tSeasonDetail.toEntity(),
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      id: tvId,
      seasonNumber: seasonNumber,
    )));

    expect(find.text('Season 1'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(
        find.byType(EpisodeCard), findsNWidgets(tSeasonDetail.episodes.length));
  });

  testWidgets('Should display loading when loading', (tester) async {
    final expected = TvSeasonDetailState.initial().copyWith(
      state: RequestState.Loading,
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      id: tvId,
      seasonNumber: seasonNumber,
    )));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display error when error', (tester) async {
    final expected = TvSeasonDetailState.initial().copyWith(
      state: RequestState.Error,
      message: "Error",
    );

    when(mockNotifier.state).thenReturn(expected);
    when(mockNotifier.stream).thenAnswer((_) => Stream.value(expected));

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      id: tvId,
      seasonNumber: seasonNumber,
    )));

    expect(find.text("Error"), findsOneWidget);
  });
}
