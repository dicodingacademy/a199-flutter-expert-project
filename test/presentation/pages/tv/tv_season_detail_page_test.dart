import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/presentation/pages/tv/tv_season_detail_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_session_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_season_detail_page_test.mocks.dart';

@GenerateMocks([TvSeasonDetailNotifier])
void main() {
  late MockTvSeasonDetailNotifier mockNotifier;

  final tvId = 1;
  final seasonNumber = 1;

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
    mockNotifier = MockTvSeasonDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeasonDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display detail', (tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.seasonDetail).thenReturn(tSeasonDetail.toEntity());

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
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      id: tvId,
      seasonNumber: seasonNumber,
    )));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display error when error', (tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn("Error");

    await tester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
      id: tvId,
      seasonNumber: seasonNumber,
    )));

    expect(find.text("Error"), findsOneWidget);
  });
}
