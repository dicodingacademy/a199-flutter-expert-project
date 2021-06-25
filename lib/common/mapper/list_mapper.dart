import 'package:ditonton/common/mapper/mapper.dart';

abstract class ListMapper<I, O> extends Mapper<List<I>, List<O>> {}

class ListMapperImpl<I, O> implements ListMapper<I, O> {
  final Mapper<I, O> mapper;

  ListMapperImpl(this.mapper);

  @override
  List<O> map(List<I> input) {
    return input.map((e) => mapper.map(e)).toList();
  }
}
