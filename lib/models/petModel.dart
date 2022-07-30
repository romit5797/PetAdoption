import 'package:hive/hive.dart';
part 'petModel.g.dart';

@HiveType(typeId: 0)
class PetModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool adopted;
  @HiveField(3)
  String location;
  @HiveField(4)
  String description;
  @HiveField(5)
  List<String> attributes;
  @HiveField(6)
  String type;
  @HiveField(7)
  num price;
  @HiveField(8)
  String breed;
  @HiveField(9)
  List<String> images;
  @HiveField(10)
  String gender;
  @HiveField(11)
  String age;

  PetModel(
      {required this.id,
      required this.name,
      required this.adopted,
      required this.location,
      required this.description,
      required this.attributes,
      required this.type,
      required this.price,
      required this.breed,
      required this.images,
      required this.gender,
      required this.age});

  // PetModel.fromJson(Map<String, dynamic> json) {
  //   this.id = json["_id"];
  //   this.name = json["name"];
  //   this.adopted = json["adopted"];
  //   this.location = json["location"];
  //   this.description = json["description"];
  //   this.attributes =
  //       (json["attributes"] as List)?.map((item) => item as String)?.toList();
  //   this.type = json["type"];
  //   this.price = json["price"];
  //   this.breed = json["breed"];
  //   this.images = json["images"];
  //   this.gender = json["gender"];
  // }
}
