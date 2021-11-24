part of 'tv_season_detail_cubit.dart';

class TvSeasonDetailState extends Equatable {
  final SeasonDetail? seasonDetail;
  final RequestState state;
  final String message;

  const TvSeasonDetailState({
    required this.state,
    required this.message,
    required this.seasonDetail,
  });

  factory TvSeasonDetailState.initial() {
    return const TvSeasonDetailState(
      state: RequestState.Empty,
      message: '',
      seasonDetail: null,
    );
  }

  TvSeasonDetailState copyWith({
    RequestState? state,
    String? message,
    SeasonDetail? seasonDetail,
  }) {
    return TvSeasonDetailState(
      state: state ?? this.state,
      message: message ?? this.message,
      seasonDetail: seasonDetail ?? this.seasonDetail,
    );
  }

  @override
  List<Object> get props => [state, message];
}
