import 'package:flutter/material.dart';
import 'package:videojuegos/src/games/snake.dart';
import 'package:videojuegos/src/utils/routes.dart';

import 'src/home_page.dart';
import 'src/utils/theme_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Components',
        home: HomePage(),
        theme: tema(),
        routes: getRoutes());
  } //u

}
