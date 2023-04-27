import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

const List<Color> settingsColors = [
  Colors.teal,
  Colors.greenAccent,
  Colors.green,
  Colors.lightGreen,
  Colors.lightGreenAccent,
  Colors.lime,
  Colors.indigo,
  Colors.indigoAccent,
  Colors.blue,
  Colors.cyan,
  Colors.lightBlue,
  Colors.pink,
  Colors.pinkAccent,
  Colors.orange,
  Colors.deepOrange,
  Color.fromARGB(255, 104, 20, 14),
  Colors.brown,
  Color(0xffbb86fc),
  Color(0xff6200ee),
  Colors.grey,
];

platformNavigateTo({
  required BuildContext context,
  required Widget screen,
  MaterialPageRouteData? materialPageRouteData,
  CupertinoPageRouteData? cupertinoPageRouteData,
}) {
  Navigator.push(
    context,
    platformPageRoute(
      material: (context, platform) =>
          materialPageRouteData ?? MaterialPageRouteData(),
      cupertino: (context, platform) =>
          cupertinoPageRouteData ?? CupertinoPageRouteData(),
      context: context,
      builder: (context) => screen,
    ),
  );
}
