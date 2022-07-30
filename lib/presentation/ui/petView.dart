import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/petCubit.dart';
import '../../models/petModel.dart';
import '../../utils/staticMethods.dart';
import '../details/detailScreen.dart';

class PetView extends StatelessWidget {
  final PetModel pet;
  final Color color;
  final int index;
  const PetView(
      {Key? key, required this.pet, required this.color, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () async {
              if (color != Colors.grey) {
                // final result = await
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<PetCubit>(context),
                            child: DetailScreen(pet: pet, index: index))));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  // ignore: unnecessary_const
                  content: const Text(
                    "This pet already adopted",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: Container(
              height: 110,
              margin: EdgeInsets.only(
                  bottom: 20,
                  left: StaticMethods.getMargin(context),
                  right: StaticMethods.getMargin(context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  imageBox(pet.images[0], color),
                  Expanded(child: animalTextBox(pet, context)),
                ],
              ),
            )));
  }

  Widget imageBox(String image, Color color) {
    return Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Hero(
            tag: 'imageHero$index',
            child: Image.network(
              image,
              height: 110,
              width: 110,
              fit: BoxFit.contain,
              errorBuilder: (context, object, stackTrace) {
                return const SizedBox(
                    height: 110,
                    width: 110,
                    child: Center(
                        child: Text(
                      'Unable to load',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )));
              },
            )));
  }

  Widget animalTextBox(PetModel pet, BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
    return Container(
        height: 110,
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 25,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(pet.name,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline1)),
                    Text(
                        color != Colors.grey
                            ? "₹${pet.price.toString().replaceAllMapped(reg, mathFunc)}"
                            : "Adopted",
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText2),
                  ],
                )),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            Text('${pet.gender} - ${pet.age}',
                maxLines: 2, style: Theme.of(context).textTheme.bodyText1),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            Expanded(
                child: Text(pet.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1))
          ],
        ));
  }
}
