import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/bloc/petCubit.dart';
import 'package:pet_adoption/presentation/home/homeScreen.dart';
import 'package:pet_adoption/theme.dart';
import 'package:pet_adoption/utils/hiveHandler.dart';

void main() async {
  await HiveHandler.initalise();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<PetCubit>(create: (BuildContext context) => PetCubit()),
      ],
      child: MaterialApp(
          title: 'Pet Demo',
          themeMode: ThemeMode.system,
          theme: PetAppTheme.lightTheme,
          darkTheme: PetAppTheme.darkTheme,
          home: const HomeScreen())));
}
