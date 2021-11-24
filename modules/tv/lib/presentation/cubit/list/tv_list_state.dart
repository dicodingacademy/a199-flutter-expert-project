part of 'tv_list_cubit.dart';

class TvListState extends Equatable {
  final List<Tv> nowPlayingTvs;
  final RequestState nowPlayingState;
  final List<Tv> popularTvs;
  final RequestState popularTvsState;
  final List<Tv> topRatedTvs;
  final RequestState topRatedTvsState;
  final String message;

  const TvListState({
    required this.nowPlayingTvs,
    required this.nowPlayingState,
    required this.popularTvs,
    required this.popularTvsState,
    required this.topRatedTvs,
    required this.topRatedTvsState,
    required this.message,
  });

  factory TvListState.initial() {
    return const TvListState(
      nowPlayingTvs: [],
      nowPlayingState: RequestState.Empty,
      popularTvs: [],
      popularTvsState: RequestState.Empty,
      topRatedTvs: [],
      topRatedTvsState: RequestState.Empty,
      message: '',
    );
  }

  TvListState copyWith({
    List<Tv>? nowPlayingTvs,
    RequestState? nowPlayingState,
    List<Tv>? popularTvs,
    RequestState? popularTvsState,
    List<Tv>? topRatedTvs,
    RequestState? topRatedTvsState,
    String? message,
  }) {
    return TvListState(
      nowPlayingTvs: nowPlayingTvs ?? this.nowPlayingTvs,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularTvs: popularTvs ?? this.popularTvs,
      popularTvsState: popularTvsState ?? this.popularTvsState,
      topRatedTvs: topRatedTvs ?? this.topRatedTvs,
      topRatedTvsState: topRatedTvsState ?? this.topRatedTvsState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        nowPlayingTvs,
        nowPlayingState,
        popularTvs,
        popularTvsState,
        topRatedTvs,
        topRatedTvsState,
        message,
      ];
}
