import 'package:flutter/material.dart';
import 'package:videojuegos/src/games/DinoGame.dart';
//import 'package:videojuegos/src/games/homepage.dart';
import 'package:videojuegos/src/games/snake.dart';
import 'package:videojuegos/src/home_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'snake': (BuildContext context) => PlaySnake(),
    'home': (BuildContext context) => HomePage(),
    'dinoGame': (BuildContext context) => DinoGame(),
    //'dinoGame': (BuildContext context) => HomePagee(),
  };
}
