import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pet_adoption/data/petData.dart';
import 'package:pet_adoption/models/petModel.dart';

class PetCubit extends Cubit<List<PetModel>> {
  PetCubit()
      : super(Hive.box<PetModel>('petList').values.toList().isEmpty
            ? PetData.petList
            : Hive.box<PetModel>('petList').values.toList());

  final List<PetModel> list =
      Hive.box<PetModel>('petList').values.toList().isEmpty
          ? PetData.petList
          : Hive.box<PetModel>('petList').values.toList();

  void updateCategory(String type) {
    emit(type == "All"
        ? list
        : list
            .where((pet) => pet.type.toLowerCase() == type.toLowerCase())
            .toList());
  }

  void searchList(key) {
    String searchQuery = key.toLowerCase();
    List<PetModel> searchList = [];
    List<PetModel> tempList = [];

    //FIND PATTERN FROM USER'S INPUT
    String pattern = "";
    for (var rune in searchQuery.runes) {
      //character -> String.fromCharCode(rune)
      pattern += "(?=.*${String.fromCharCode(rune)})";
    }

    RegExp regex = RegExp(pattern);
    //FILTER EXERCISES
    for (var element in list) {
      //if (element.exerciseName=="Overhead press") print(element.otherName);
      if (element.name.toLowerCase().contains(searchQuery) ||
          element.type.toLowerCase().contains(searchQuery) ||
          element.breed.toLowerCase().contains(searchQuery)) {
        searchList.add(element);
      } else if (regex.hasMatch(element.name.toLowerCase()) ||
          regex.hasMatch(element.type.toLowerCase()) ||
          regex.hasMatch(element.breed.toLowerCase())) {
        tempList.add(element);
      }
    }

    searchList.addAll(tempList);
    emit(searchList);
  }

  void adoptPet(PetModel pet) {
    for (int i = 0; i < list.length; i++) {
      if (state[i].id == pet.id) {
        list[i].adopted = true;
        Hive.box<PetModel>('petList').putAt(i, pet);

        break;
      }
    }

    emit(List.from(list));
  }

  void getHistory() {
    emit(list.where((pet) => pet.adopted).toList());
  }
}
