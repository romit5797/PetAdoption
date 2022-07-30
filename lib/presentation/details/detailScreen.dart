import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/bloc/petCubit.dart';
import 'package:pet_adoption/models/petModel.dart';
import 'package:pet_adoption/presentation/details/imageScreen.dart';
import 'package:pet_adoption/theme.dart';
import 'package:lottie/lottie.dart';

import '../../utils/staticMethods.dart';

class DetailScreen extends StatefulWidget {
  final PetModel pet;
  final int index;
  const DetailScreen({Key? key, required this.pet, required this.index})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        bottomNavigationBar: InkWell(
          onTap: () async {
            if (!widget.pet.adopted) {
              context.read<PetCubit>().adoptPet(widget.pet);
              await showMessage();
              Navigator.pop(context, 'Yep!');
            }
          },
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: StaticMethods.getMargin(context), vertical: 10),
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(widget.pet.adopted ? 0.5 : 1),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Text(widget.pet.adopted ? 'Already adopted' : 'Adopt Me',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600))),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: imageView(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: descriptionView(),
              )
            ],
          ),
        ));
  }

  Widget imageView() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/8.webp"),
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
        ),
      ),
      child: Stack(children: [
        GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ImageScreen(url: widget.pet.images[1]);
              }));
            },
            child: Hero(
                tag: 'imageHero${widget.index}',
                child: Image.network(widget.pet.images[0], fit: BoxFit.cover))),
        Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  child: const Center(
                      child: Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 26))),
            )),
      ]),
    );
  }

  Widget descriptionView() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.symmetric(horizontal: StaticMethods.getMargin(context)),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [header(), keyInfoList(), descriptionBox()])),
    );
  }

  Widget header() {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        margin: const EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  widget.pet.name,
                  style: Theme.of(context).textTheme.headline2,
                )),
                Text(
                    "₹${widget.pet.price.toString().replaceAllMapped(reg, mathFunc)}",
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Text(widget.pet.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ));
  }

  Widget keyInfoList() {
    return Container(
        height: 70,
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              infoBox("Sex", widget.pet.gender,
                  Theme.of(context).colorScheme.primary),
              infoBox("Age", widget.pet.age,
                  Theme.of(context).colorScheme.secondary),
              infoBox("Breed", widget.pet.breed,
                  Theme.of(context).colorScheme.tertiary),
            ]));
  }

  Widget infoBox(String title, String value, Color color) {
    return Container(
        height: 70,
        width: MediaQuery.of(context).size.width * 0.22,
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade100)),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Text(value,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: PetAppTheme.titleFontName,
                    color: Colors.white)),
          ],
        ));
  }

  Widget descriptionBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description", style: Theme.of(context).textTheme.headline3),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
        Text(widget.pet.description,
            style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }

  Future showMessage() async {
    await showGeneralDialog(
      barrierLabel: "Barrier",
      //barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 320,
            width: 300,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(-2, 2)),
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(1.2, -1.2)),
              ],
            ),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset("assets/images/confetti.json",
                      height: 200, width: 200),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    "Congratulations, You've now adopted ${widget.pet.name}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: PetAppTheme.titleFontName,
                        decoration: TextDecoration.none),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                ],
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Material(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ))))
            ]),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }
}
