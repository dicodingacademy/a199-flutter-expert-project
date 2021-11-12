import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:flutter/foundation.dart';

class PopularTvsNotifier extends ChangeNotifier {
  final GetPopularTvs getPopularTvs;

  PopularTvsNotifier(this.getPopularTvs);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvs = [];
  List<Tv> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvsData) {
        _tvs = tvsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
