import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pet_adoption/data/petData.dart';
import 'package:pet_adoption/presentation/ui/petView.dart';
import 'package:pet_adoption/utils/staticMethods.dart';
import '../../bloc/cagtegoryCubit.dart';
import '../../bloc/paginationCubit.dart';
import '../../models/petModel.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  List<PetModel> myPets() {
    List<PetModel> list = [];
    List<PetModel> originalList = Hive.box<PetModel>('petList').isEmpty
        ? PetData.petList
        : Hive.box<PetModel>('petList').values.toList();
    for (final pet in originalList) {
      if (pet.adopted) {
        list.add(pet);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: StaticMethods.customAppBar(context, "Adoption History"),
        body: BlocProvider(
            create: (_) => CategoryCubit(),
            child: SafeArea(
              child: SingleChildScrollView(
                child: myPets().isEmpty
                    ? textTile("No pets adopted yet", context)
                    : historyList(),
              ),
            )));
  }

  Widget textTile(String title, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(title, style: Theme.of(context).textTheme.headline1));
  }

  Widget historyList() {
    final list = myPets();
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: BlocProvider(
            create: (_) => PaginationCubit(),
            child: BlocBuilder<PaginationCubit, int>(
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
                                  pet: list[index],
                                  color: colors[index % 4],
                                  index: index);
                            },
                          ),
                          if (limit < list.length)
                            InkWell(
                                onTap: () =>
                                    context.read<PaginationCubit>().loadMore(),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 20, left: StaticMethods.getMargin(context)),
                                    child: Text(
                                      "View more",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    )))
                        ]))));
  }
}
