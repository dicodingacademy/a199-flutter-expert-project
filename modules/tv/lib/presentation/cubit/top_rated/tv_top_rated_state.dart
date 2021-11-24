part of 'tv_top_rated_cubit.dart';

class TvTopRatedState extends Equatable {
  final RequestState state;
  final List<Tv> tvs;
  final String message;

  const TvTopRatedState({
    required this.state,
    required this.tvs,
    required this.message,
  });

  factory TvTopRatedState.initial() {
    return const TvTopRatedState(
      state: RequestState.Empty,
      tvs: [],
      message: '',
    );
  }

  TvTopRatedState copyWith({
    RequestState? state,
    List<Tv>? tvs,
    String? message,
  }) {
    return TvTopRatedState(
      state: state ?? this.state,
      tvs: tvs ?? this.tvs,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [state, tvs, message];
}
