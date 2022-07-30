import 'package:bloc_test/bloc_test.dart';
import 'package:pet_adoption/bloc/paginationCubit.dart';
import 'package:test/test.dart';

void main() {
  group('PaginationCubit', () {
    PaginationCubit? pageCubit;

    setUp(() {
      pageCubit = PaginationCubit();
    });

    tearDown(() {
      pageCubit?.close();
    });

    test('initial state of PaginationCubit is 5', () {
      expect(pageCubit?.state, 5);
    });

    blocTest(
        'the PaginationCubit should emit a 10 when the increment function is called',
        build: () => PaginationCubit(),
        act: (PaginationCubit cubit) => cubit.loadMore(),
        expect: () => [10]);
  });
}
