import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/models/petModel.dart';
import 'package:pet_adoption/presentation/ui/petView.dart';
import 'package:pet_adoption/utils/staticMethods.dart';
import '../../bloc/cagtegoryCubit.dart';
import '../../bloc/paginationCubit.dart';
import '../../bloc/petCubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';
  Timer? _debounce;

  @override
  void dispose() {
    super.dispose();
    if (_debounce != null) _debounce?.cancel();
  }

  _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<PetCubit>().searchList(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: StaticMethods.customAppBar(context, "Search"),
        body: BlocProvider(
            create: (_) => CategoryCubit(),
            child: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBar(),
                  animalList(),
                ],
              )),
            )));
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
                                pet: list[index],
                                color: list[index].adopted
                                    ? Colors.grey
                                    : colors[index % 4],
                                index: index,
                              );
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
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    )))
                        ]))));
  }

  Widget searchBar() {
    return Container(
        height: 75,
        margin: EdgeInsets.only(bottom: 20, left: StaticMethods.getMargin(context), right: StaticMethods.getMargin(context)),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
            textInputAction: TextInputAction.done,
            autofocus: true,
            style: Theme.of(context).textTheme.bodyText1,
            onChanged: (value) => _onSearchChanged(value),
            decoration: InputDecoration(
                fillColor: Theme.of(context)
                    .colorScheme
                    .inverseSurface
                    .withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.search),
                hintText: 'Try name , breed or type',
                hintStyle: Theme.of(context).textTheme.bodyText1,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero)));
  }
}
