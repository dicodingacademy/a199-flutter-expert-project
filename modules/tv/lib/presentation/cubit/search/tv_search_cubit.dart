import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tvs.dart';

part 'tv_search_state.dart';

class TvSearchCubit extends Cubit<TvSearchState> {
  final SearchTvs searchTvs;

  TvSearchCubit({required this.searchTvs}) : super(TvSearchState.initial());

  Future<void> fetchTvSearch(String query) async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await searchTvs.execute(query);

    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          state: RequestState.Loaded,
          searchResult: data,
        ));
      },
    );
  }
}
