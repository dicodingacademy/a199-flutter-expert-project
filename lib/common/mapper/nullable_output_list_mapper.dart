import 'package:ditonton/common/mapper/mapper.dart';

abstract class NullableOutputListMapper<I, O>
    extends Mapper<List<I>, List<O>?> {}

class NullableOutputListMapperImpl<I, O>
    implements NullableOutputListMapper<I, O> {
  final Mapper<I, O> mapper;

  NullableOutputListMapperImpl(this.mapper);

  @override
  List<O>? map(List<I> input) {
    if (input.isEmpty) {
      return null;
    }

    input.map((e) => mapper.map(e));
  }
}
