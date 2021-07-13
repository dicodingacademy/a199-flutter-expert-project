import 'package:ditonton/common/mapper/mapper.dart';

abstract class NullableInputListMapper<I, O> extends Mapper<List<I>?, List<O>> {
}

class NullableInputListMapperImpl<I, O>
    implements NullableInputListMapper<I, O> {
  final Mapper<I, O> mapper;

  NullableInputListMapperImpl(this.mapper);

  @override
  List<O> map(List<I>? input) {
    if (input == null) {
      return [];
    }
    return input.map((e) => mapper.map(e)).toList();
  }
}
