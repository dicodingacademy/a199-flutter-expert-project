part of 'tv_popular_cubit.dart';

class TvPopularState extends Equatable {
  final RequestState state;
  final List<Tv> tvs;
  final String message;

  const TvPopularState({
    required this.state,
    required this.tvs,
    required this.message,
  });

  factory TvPopularState.initial() {
    return const TvPopularState(
      state: RequestState.Empty,
      tvs: [],
      message: '',
    );
  }

  TvPopularState copyWith({
    RequestState? state,
    List<Tv>? tvs,
    String? message,
  }) {
    return TvPopularState(
      state: state ?? this.state,
      tvs: tvs ?? this.tvs,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [state, tvs, message];
}
