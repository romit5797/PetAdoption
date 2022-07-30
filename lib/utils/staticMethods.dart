import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StaticMethods {
  StaticMethods();

  static double getMargin(BuildContext context) =>
      kIsWeb && MediaQuery.of(context).size.width > 768
          ? MediaQuery.of(context).size.width * 0.03
          : 20.0;

  static AppBar customAppBar(BuildContext context, String title) => AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shadowColor: Colors.white,
        leading: IconButton(
          padding: EdgeInsets.only(
              left: kIsWeb ? StaticMethods.getMargin(context) - 8: 8,
              right: 8,
              bottom: 8,
              top: 8),
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Theme.of(context).colorScheme.inverseSurface,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
        centerTitle: true,
      );
}
