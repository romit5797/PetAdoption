import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<String> {
  CategoryCubit() : super("All");

  void updateType(String type) {
    emit(type);
  }
}
