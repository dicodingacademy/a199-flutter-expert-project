import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeasonDetailNotifier extends ChangeNotifier {
  final GetTvSeasonDetail getTvSeasonDetail;

  TvSeasonDetailNotifier({
    required this.getTvSeasonDetail,
  });

  late SeasonDetail _seasonDetail;
  SeasonDetail get seasonDetail => _seasonDetail;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeasonDetail(int id, int seasonNumber) async {
    _state = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvSeasonDetail.execute(id, seasonNumber);

    detailResult.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seasonDetail) {
        _state = RequestState.Loaded;
        _seasonDetail = seasonDetail;

        notifyListeners();
      },
    );
  }
}
