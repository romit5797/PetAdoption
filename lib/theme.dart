import 'package:flutter/material.dart';

class PetAppTheme {
  PetAppTheme();

  static const Color background = Color(0xFFFEFCFB);
  static const Color primary = Color(0xFFff6d00);
  static const Color secondary = Color(0xFF51b8b5);
  static const Color tertiary = Color(0xFF7b2cbf);

  //static const Color primary = Color(0xFF00B6F0);
  static const Color darkGrey = Color(0xFF313A44);
  static const Color silver = Color(0xFFBFC0C0);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color deactivatedText = Color(0xFF767676);
  static const String titleFontName = 'Montserrat';

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFEFCFB),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFff6d00),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.light(
        primary: Color(0xFFff6d00),
        secondary: Color(0xFF51b8b5),
        tertiary: Color(0xFF7b2cbf),
        surface: Colors.white,
        inverseSurface: darkerText),
    iconTheme: const IconThemeData(
      color: Colors.white54,
    ),
    textTheme: const TextTheme(
        subtitle2: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        subtitle1: TextStyle(
          color: Colors.white70,
          fontSize: 18.0,
        ),
        headline1: TextStyle(
          color: darkerText,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          fontFamily: titleFontName,
        ),
        headline2: TextStyle(
          color: darkerText,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontFamily: titleFontName,
        ),
        headline3: TextStyle(
          color: darkerText,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: titleFontName,
        ),
        headline4: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          fontFamily: titleFontName,
        ),
        headline5: TextStyle(
          color: deactivatedText,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        bodyText2: TextStyle(
          color: Color(0xFFff6d00),
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: titleFontName,
        ),
        bodyText1: TextStyle(
          color: deactivatedText,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        )),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Color(0xFFff6d00),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.light(
        primary: Color(0xFFff6d00),
        secondary: Color(0xFF51b8b5),
        tertiary: Color(0xFF7b2cbf),
        inverseSurface: Colors.white,
        surface: darkerText),
    iconTheme: const IconThemeData(
      color: Colors.white54,
    ),
    textTheme: const TextTheme(
        subtitle2: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        subtitle1: TextStyle(
          color: Colors.white70,
          fontSize: 18.0,
        ),
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          fontFamily: titleFontName,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontFamily: titleFontName,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: titleFontName,
        ),
        headline4: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          fontFamily: titleFontName,
        ),
        headline5: TextStyle(
          color: deactivatedText,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        bodyText2: TextStyle(
          color: Color(0xFFff6d00),
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: titleFontName,
        ),
        bodyText1: TextStyle(
          color: silver,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        )),
  );
}
