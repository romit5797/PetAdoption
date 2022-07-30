import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_adoption/models/petModel.dart';

class HiveHandler {
  static Future initalise() async {
    await Hive.initFlutter();
    registerAdapters();
    await openBoxes();
  }

  static void registerAdapters() {
    Hive.registerAdapter(PetModelAdapter());
  }

  static Future openBoxes() async {
    await Hive.openBox<PetModel>('petList');
  }

  static Future closeBoxes() async {
    if (await Hive.boxExists('petList')) {
      Hive.box<PetModel>("petList").close();
    }
  }
}
