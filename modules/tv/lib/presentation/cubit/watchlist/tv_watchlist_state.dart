part of 'tv_watchlist_cubit.dart';

class TvWatchlistState extends Equatable {
  final List<Tv> watchlistTvs;
  final RequestState watchlistState;
  final String message;

  const TvWatchlistState({
    required this.watchlistTvs,
    required this.watchlistState,
    required this.message,
  });

  factory TvWatchlistState.initial() {
    return const TvWatchlistState(
      watchlistTvs: [],
      watchlistState: RequestState.Empty,
      message: '',
    );
  }

  TvWatchlistState copyWith({
    List<Tv>? watchlistTvs,
    RequestState? watchlistState,
    String? message,
  }) {
    return TvWatchlistState(
      watchlistTvs: watchlistTvs ?? this.watchlistTvs,
      watchlistState: watchlistState ?? this.watchlistState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [watchlistTvs, watchlistState, message];
}
