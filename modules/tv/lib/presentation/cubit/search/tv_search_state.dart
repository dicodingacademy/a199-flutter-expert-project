part of 'tv_search_cubit.dart';

class TvSearchState extends Equatable {
  final RequestState state;
  final List<Tv> searchResult;
  final String message;

  const TvSearchState({
    required this.state,
    required this.searchResult,
    required this.message,
  });

  factory TvSearchState.initial() {
    return const TvSearchState(
      state: RequestState.Empty,
      searchResult: [],
      message: '',
    );
  }

  TvSearchState copyWith({
    RequestState? state,
    List<Tv>? searchResult,
    String? message,
  }) {
    return TvSearchState(
      state: state ?? this.state,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [state, searchResult, message];
}
