import 'package:flutter_bloc/flutter_bloc.dart';

class PaginationCubit extends Cubit<int> {
  PaginationCubit() : super(5);

  void loadMore() {
    emit(state + 5);
  }
}
