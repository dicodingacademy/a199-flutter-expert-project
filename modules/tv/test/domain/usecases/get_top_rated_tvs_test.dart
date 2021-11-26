import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvs usecase;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    usecase = GetTopRatedTvs(repository);
  });

  final tTvs = <Tv>[];

  test('should get list of tvs from repository', () async {
    // arrange
    when(repository.getTopRatedTvs()).thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
