part of 'tv_detail_cubit.dart';

class TvDetailState extends Equatable {
  final TvDetail? tv;
  final RequestState tvState;
  final List<Tv> tvRecommendations;
  final RequestState recommendationState;
  final String message;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  const TvDetailState({
    required this.tv,
    required this.tvState,
    required this.tvRecommendations,
    required this.recommendationState,
    required this.message,
    required this.isAddedToWatchlist,
    required this.watchlistMessage,
  });

  factory TvDetailState.initial() {
    return const TvDetailState(
      tv: null,
      tvState: RequestState.Empty,
      tvRecommendations: [],
      recommendationState: RequestState.Empty,
      message: '',
      isAddedToWatchlist: false,
      watchlistMessage: '',
    );
  }

  TvDetailState copyWith({
    TvDetail? tv,
    RequestState? tvState,
    List<Tv>? tvRecommendations,
    RequestState? recommendationState,
    String? message,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return TvDetailState(
      tv: tv ?? this.tv,
      tvState: tvState ?? this.tvState,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object> get props => [
        tvState,
        tvRecommendations,
        recommendationState,
        message,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}
