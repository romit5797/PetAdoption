import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pet_adoption/data/petData.dart';
import 'package:pet_adoption/models/petModel.dart';
import 'package:pet_adoption/presentation/history/historyScreen.dart';
import 'package:pet_adoption/presentation/home/searchScreen.dart';
import 'package:pet_adoption/presentation/ui/petView.dart';
import 'package:pet_adoption/utils/staticMethods.dart';
import '../../bloc/cagtegoryCubit.dart';
import '../../bloc/paginationCubit.dart';
import '../../bloc/petCubit.dart';
import '../details/detailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  @override
  void initState() {
    super.initState();
    //Hive.box<PetModel>('petList').clear();
    if (Hive.box<PetModel>('petList').isEmpty) {
      Hive.box<PetModel>('petList').addAll(PetData.petList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocProvider(
            create: (_) => CategoryCubit(),
            child: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBar(),
                  searchBar(),
                  textTile("New Corner"),
                  newConerList(),
                  textTile("Categories"),
                  categoryList(),
                  animalList(),
                ],
              )),
            )));
  }

  Widget appBar() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: StaticMethods.getMargin(context), vertical: 20),
      child: Row(children: [
        Expanded(
            child:
                Text("Explore", style: Theme.of(context).textTheme.headline2)),
        InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HistoryScreen())),
            child: Icon(
              Icons.history,
              size: 24,
              color: Theme.of(context).colorScheme.inverseSurface,
            ))
      ]),
    );
  }

  Widget textTile(String title) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: StaticMethods.getMargin(context)),
        child: Text(title, style: Theme.of(context).textTheme.headline1));
  }

  Widget searchBar() {
    return InkWell(
        onTap: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SearchScreen()));
          context.read<PetCubit>().updateCategory("All");
        },
        child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: EdgeInsets.only(
                bottom: 20,
                left: StaticMethods.getMargin(context),
                right: StaticMethods.getMargin(context)),
            child: Row(
              children: [
                Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle),
                    child: const Center(
                        child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ))),
                Text("Search here",
                    style: Theme.of(context).textTheme.headline5)
              ],
            )));
  }

  Widget newConerList() {
    return Container(
      height: 300,
      margin: EdgeInsets.only(left: StaticMethods.getMargin(context)),
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 20),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          newCorner(PetData.petList[6], "assets/images/british.jpg", 6),
          newCorner(PetData.petList[7], "assets/images/norwegian.jpg", 7),
          newCorner(PetData.petList[5], "assets/images/persian.jpg", 5),
        ],
      ),
    );
  }

  Widget newCorner(PetModel pet, String image, int index) {
    return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(pet: pet, index: index))),
        child: Container(
          height: 300,
          width: 250,
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  image,
                  height: 300,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  width: 250,
                  height: 128,
                  // Note: without ClipRect, the blur region will be expanded to full
                  // size of the Image instead of custom size
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: textBox(pet)),
              )
            ],
          ),
        ));
  }

  Widget categoryList() {
    return Container(
        height: 80,
        margin: EdgeInsets.only(left: StaticMethods.getMargin(context)),
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: <Widget>[
              categoryBox("All", "assets/images/all.png"),
              categoryBox("Dog", "assets/images/dog.png"),
              categoryBox("Cat", "assets/images/cat.png"),
              categoryBox("Bird", "assets/images/bird.png"),
              categoryBox("Reptile", "assets/images/reptile.png"),
            ]));
  }

  Widget categoryBox(String text, String image) {
    return BlocBuilder<CategoryCubit, String>(
        builder: (context, type) => InkWell(
            onTap: () {
              context.read<CategoryCubit>().updateType(text);
              context.read<PetCubit>().updateCategory(text);
            },
            child: Container(
                height: 40,
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: type == text
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      image,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    Text(text,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: type == text ? Colors.white : Colors.black)),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                  ],
                ))));
  }

  Widget animalList() {
    return BlocProvider(
        create: (_) => PaginationCubit(),
        child: BlocBuilder<PetCubit, List<PetModel>>(
            builder: (context, list) => BlocBuilder<PaginationCubit, int>(
                builder: (context, limit) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemCount:
                                limit < list.length ? limit : list.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              List<Color> colors = const [
                                Colors.blue,
                                Colors.orange,
                                Colors.green,
                                Colors.red
                              ];
                              return PetView(
                                  key: ValueKey(list[index].id),
                                  pet: list[index],
                                  color: list[index].adopted
                                      ? Colors.grey
                                      : colors[index % 4],
                                  index: index);
                            },
                          ),
                          if (limit < list.length)
                            InkWell(
                                onTap: () =>
                                    context.read<PaginationCubit>().loadMore(),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 20,
                                        left: StaticMethods.getMargin(context)),
                                    child: Text("View more",
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2)))
                        ]))));
  }

  Widget textBox(PetModel pet) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pet.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            Text(
              '${pet.gender} - ${pet.age}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            Text(pet.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ));
  }
}
